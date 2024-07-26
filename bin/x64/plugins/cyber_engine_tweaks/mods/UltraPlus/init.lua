UltraPlus = {
	__VERSION	 = '5.1.2',
	__DESCRIPTION = 'Better Path Tracing, Ray Tracing and Hotfixes for CyberPunk',
	__URL		 = 'https://github.com/sammilucia/cyberpunk-ultra-plus',
	__LICENSE	 = [[
	MIT No Attribution

	Copyright 2024 SammiLucia, Xerme, FireKahuna, WoaDmulL

	Permission is hereby granted, free of charge, to any person obtaining a copy of this
	software and associated documentation files (the 'Software'), to deal in the Software
	without restriction, including without limitation the rights to use, copy, modify,
	merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so.

	THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}

local logger = require('helpers/logger')
local var = require('helpers/variables')
local config = require('helpers/config')
local options = require('helpers/options')
local render = require('render')
local Cyberpunk = require('helpers/Cyberpunk')
local gameSession = {
	active = false,
	time = nil,
	lastTime = nil,
	fastTravel = false,
	isInMenu = false,
}
local stats = {
	fps = 0,
}
local timer = {
	lazy = 0,
	fast = 0,
	weather = 0,
	paused = false,
	FAST = 1.0,
	LAZY = 5.0,
	WEATHER = 910, -- 15:10 hours
}

local function isGameSessionActive()
	-- check if the game is active or not, which turns out to be quite difficult!
	local time = Cyberpunk.GetPlayTime()

	local blackboardDefs = Game.GetAllBlackboardDefs()
	local blackboardUI = Game.GetBlackboardSystem():Get(blackboardDefs.UI_System)
	local blackboardPM = Game.GetBlackboardSystem():Get(blackboardDefs.PhotoMode)

	local menuActive = blackboardUI:GetBool(blackboardDefs.UI_System.IsInMenu)
	local photoModeActive = blackboardPM:GetBool(blackboardDefs.PhotoMode.IsActive)
	local tutorialActive = Game.GetTimeSystem():IsTimeDilationActive('UI_TutorialPopup')

	if time ~= gameSession.lastTime and gameSession.active
	and not gameSession.fastTravel
	and not menuActive
	and not photoModeActive
	and not tutorialActive
	and not Cyberpunk.IsPreGame()
	and not gameSession.isInMenu then
		timer.paused = false
	else
		config.ptNext.active = false
		config.ptNext.stage1 = false
		timer.paused = true
	end

	gameSession.lastTime = time
end

local activeTimers = {}
function Wait(seconds, callback)
	-- non-blocking wait
	table.insert(activeTimers, { countdown = seconds, callback = callback })
end

local function saveUserSettingsJson()
	-- instructs game to save settings to UserSettings.json
	if timer.paused then
		return
	end

	Cyberpunk.Save()
	var.confirmationRequired = false
	logger.info('Cyberpunk successfully saved UserSettings.json')
end

local function confirmChanges()
	-- confirm graphics menu changes to Cyberpunk
	if var.ultraPlusActive and Cyberpunk.NeedsConfirmation() then
		Cyberpunk.Confirm()
	end
end

function LoadIni(config)
	-- pushes an ini file into live game settings
	local iniData = {}
	local category

	local path = 'config/' .. config .. '.ini'
	local file = io.open(path, 'r')
	if not file then
		logger.info('Failed to open file:', path)
		return
	end

	logger.info('	(Loading', path .. ')')
	for line in file:lines() do
		line = line:match('^%s*(.-)%s*$') -- trim whitespace

		if line == '' or string.sub(line, 1, 1) == ';' then
			goto continue
		end

		local currentCategory = line:match('%[(.+)%]') -- match category lines
		if currentCategory then
			category = currentCategory
			iniData[category] = iniData[category] or {}
			goto continue
		end

		local item, value = line:match('([^=]+)%s*=%s*([^;]+)') -- match items and values, ignore comments
		if item and value then
			item = item:match('^%s*(.-)%s*$')
			value = value:match('^%s*(.-)%s*$')
			iniData[category][item] = value
			local success, result = pcall(Cyberpunk.SetOption, category, item, value)
			if not success then
				logger.info('SetOption failed:', result)
			end
		end

		::continue::
	end
	file:close()
end

function LoadSettings()
	-- get game's live settings, then replace with config.json settings (if they exist and are valid)
	local settingsTable = {}
	local settingsCategories = {
		options.tweaks,
		options.ptFeatures,
		options.rasterFeatures,
		options.postProcessFeatures,
		options.miscFeatures,
	}

	for _, category in pairs(settingsCategories) do
		for _, setting in ipairs(category) do
			local currentValue = Cyberpunk.GetOption(setting.category, setting.item)
			settingsTable[setting.item] = { category = setting.category, value = currentValue }
		end
	end

	local file = io.open('config.json', 'r')
	if not file then
		return
	end

	local rawJson = file:read('*a')
	file:close()

	local success, result = pcall(json.decode, rawJson)

	if not success or not result.UltraPlus then
		logger.info('Could not read config.json:', result)
		return
	end

	logger.info('Loading user settings...')
	for item, value in pairs(result.UltraPlus) do
		if settingsTable[item] and not string.match(item, '^internal') then
			settingsTable[item].value = value
		elseif string.match(item, '^internal') then
			local key = string.match(item, '^internal%.(%w+)$')
			if key then
				logger.info('    Found user config', key..':', value)
				var.settings[key] = value
			end
		end
	end

	for item, setting in pairs(settingsTable) do
		Cyberpunk.SetOption(setting.category, item, setting.value)
	end

	-- Load saved graphics settings
	local graphicsSettings = {
		{ category = '/graphics/presets', item = 'ResolutionScaling' },
		{ category = '/graphics/presets', item = 'DLSS' },
		{ category = '/graphics/presets', item = 'FSR2' },
		{ category = '/graphics/presets', item = 'XESS' },
		{ category = '/graphics/basic', item = 'DepthOfField' },
		{ category = '/graphics/basic', item = 'LensFlares' },
		{ category = '/graphics/basic', item = 'ChromaticAberration' },
		{ category = '/graphics/basic', item = 'FilmGrain' },
		{ category = '/graphics/basic', item = 'MotionBlur' },
	}

	logger.info('Restoring Cyberpunk graphics settings from last session...')
	for _, setting in pairs(graphicsSettings) do
		local value = result.UltraPlus[setting.item]
		if value ~= nil then
			Cyberpunk.SetOption(setting.category, setting.item, value)
		end
	end
	logger.info('    (Done)')
end

function SaveSettings()
	-- save Ultra+ settings to config.json
	local UltraPlus = {}
	local settingsCategories = {
		options.tweaks,
		options.ptFeatures,
		options.rasterFeatures,
		options.postProcessFeatures,
		options.miscFeatures,
	}

	for _, currentCategory in pairs(settingsCategories) do
		for _, currentSetting in pairs(currentCategory) do
			UltraPlus[currentSetting.item] = Cyberpunk.GetOption(currentSetting.category, currentSetting.item)
		end
	end

	UltraPlus['internal.mode'] = var.settings.mode
	UltraPlus['internal.quality'] = var.settings.quality
	UltraPlus['internal.sceneScale'] = var.settings.sceneScale
	UltraPlus['internal.vram'] = var.settings.vram
	UltraPlus['internal.graphics'] = var.settings.graphics
	UltraPlus['internal.nsgddCompatible'] = var.settings.nsgddCompatible
	UltraPlus['internal.rayReconstruction'] = var.settings.rayReconstruction
	UltraPlus['internal.enableTargetFps'] = var.settings.enableTargetFps
	UltraPlus['internal.targetFps'] = var.settings.targetFps
	UltraPlus['internal.enableConsole'] = var.settings.enableConsole

	local settingsTable = { UltraPlus = UltraPlus }

	local success, result = pcall(json.encode, settingsTable)
	if not success then
		logger.info('Error saving config.json:', result)
		return
	end

	local rawJson = result
	local file = io.open('config.json', 'w')
	if not file then
		logger.info('Error opening config.json for writing')
		return
	end
	file:write(rawJson)
	file:close()
end

local function toggleRayReconstruction(state)
	while Cyberpunk.GetOption('/graphics/presets', 'DLSS_D') ~= state do
		Wait(1.0, function()
			Cyberpunk.SetOption('/graphics/presets', 'DLSS_D', state)
		end)
	end
end

local function preparePTNext()
	-- if not in PTNext mode, always disable ReGIR
	-- otherwise disable PTNext in preparation for loading
	if config.ptNext.stage2 then
		return
	end

	if var.settings.mode ~= var.mode.PTNEXT then
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableSeparateDenoising', true)

		logger.info('    PTNext is not in use')
		config.ptNext.active = false
		return
	end

	Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)
	Cyberpunk.SetOption('Editor/RTXDI', 'EnableSeparateDenoising', false)

	logger.info('    PTNext is ready to load')
	config.ptNext.stage2 = true
	config.ptNext.active = false
end

local function enablePTNext()
	if config.ptNext.active or var.settings.mode ~= var.mode.PTNEXT then
		return
	end

	Wait(1.5, function()
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', true)

		local usingNRD = Cyberpunk.GetOption('RayTracing', 'EnableNRD')
		if not usingNRD then
			logger.info('    (RR is in use)')
			-- if we can work out why local lights/vegetation need separate denoiser info
			-- Dogtown we can remove this!! it looks horrible and only needed in Dogtown
			Cyberpunk.SetOption('Editor/RTXDI', 'EnableSeparateDenoising', true)
		else
			logger.info('    (NRD is in use)')
		end
	end)

	config.ptNext.active = true
	logger.info('    PTNext is active')
end

local function doRainPathTracingFix()
	-- enable particle PT integration unless player is outdoors AND it's raining
	if var.settings.rain and not var.settings.indoors then
		logger.info('    (It\'s raining: Enabling separate particle colour)')
		Cyberpunk.SetOption('Rendering', 'DLSSDSeparateParticleColor', true)
	else
		logger.info('    (It\'s not raining: Disabling separate particle colour)')
		Cyberpunk.SetOption('Rendering', 'DLSSDSeparateParticleColor', false)
	end
end

local function doRayReconstructionFix()
	-- while RR is enabled, continually disable NRD to work around CP FPS slowdown bug entering
	-- vehicles or cutscenes. also controls EnableGradients which doesn't work with NRD
	if not Cyberpunk.GetOption('/graphics/presets', 'DLSS_D') then
		Cyberpunk.SetOption('Editor/RTXDI', 'EnableGradients', false) -- needs testing with NRD again
		Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', true)
		return
	end

	Cyberpunk.SetOption('RayTracing', 'EnableNRD', false)
	Cyberpunk.SetOption('Editor/RTXDI', 'EnableGradients', true) -- needs testing with NRD again
	Cyberpunk.SetOption('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', false)
end

local function saveGraphicsSettings()
	-- snapshots game's graphics menu
	local graphicsSettings = {
		{ category = '/graphics/presets', item = 'ResolutionScaling' },
		{ category = '/graphics/presets', item = 'DLSS' },
		{ category = '/graphics/presets', item = 'FSR2' },
		{ category = '/graphics/presets', item = 'XESS' },
		{ category = '/graphics/basic', item = 'DepthOfField' },
		{ category = '/graphics/basic', item = 'LensFlares' },
		{ category = '/graphics/basic', item = 'ChromaticAberration' },
		{ category = '/graphics/basic', item = 'FilmGrain' },
		{ category = '/graphics/basic', item = 'MotionBlur' },
	}

	local graphicsSettingsTable = {}
	for _, setting in pairs(graphicsSettings) do
		local currentValue = Cyberpunk.GetOption(setting.category, setting.item)
		graphicsSettingsTable[setting.item] = { category = setting.category, value = currentValue }
	end

	local file = io.open('config.json', 'r')
	local configTable
	if file then
		local rawJson = file:read('*a')
		file:close()
		local success, result = pcall(json.decode, rawJson)
		if success and result.UltraPlus then
			configTable = result
		end
	end

	if not configTable then
		configTable = { UltraPlus = {} }
	end

	for item, setting in pairs(graphicsSettingsTable) do
		configTable.UltraPlus[item] = setting.value
	end

	local success, result = pcall(json.encode, configTable)
	if not success then
		logger.info('Error saving graphics settings to config.json:', result)
		return
	end

	local rawJson = result
	local file = io.open('config.json', 'w')
	if not file then
		logger.info('Error opening config.json for writing')
		return
	end
	file:write(rawJson)
	file:close()

	logger.info('Successfully stored Cyberpunk graphics settings')
end

local function doWindowClose()
	-- run tasks just after CET window is closed. delay needed to avoid CTDs
	saveGraphicsSettings()

	if not var.ultraPlusActive or timer.paused or gameSession.isInMenu then
		return
	end

	if var.settings.mode == var.mode.PTNEXT then
		Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', false)
	end

	Wait(1.0, function()
		saveUserSettingsJson()
	end)

	if var.settings.mode == var.mode.PTNEXT then
		Wait(1.0, function()
			Cyberpunk.SetOption('Editor/ReGIR', 'UseForDI', true)
		end)
	end
end

local function setStatus()
	if var.settings.mode == var.mode.PTNEXT and not config.ptNext.active then
		config.status = 'Reload a save to activate PTNext'
	elseif var.confirmationRequired then
		config.status = 'Close CET overlay to finish applying settings'
	elseif config.ptNext.primed then
		config.status = 'PTNext is ready to load'
	else
		config.status = 'Ready.'
	end
end

local function doFastUpdate()
	-- runs every timer.FAST seconds
	isGameSessionActive()
	confirmChanges()
	setStatus()

	if var.settings.mode == var.mode.PTNEXT and not config.ptNext.active and not config.ptNext.stage1 then
		preparePTNext()
	end

	if timer.paused then
		return
	end

	enablePTNext()
	doRayReconstructionFix()

	local testRain = Cyberpunk.IsRaining()
	local testIndoors = IsEntityInInteriorArea(GetPlayer())

	if testRain ~= var.settings.rain or testIndoors ~= var.settings.indoors then
		var.settings.rain = testRain
		var.settings.indoors = testIndoors
		doRainPathTracingFix()
	end
end

local function doLazyUpdate()
	-- runs every timer.LAZY seconds
	if timer.paused then
		return
	end

	-- begin time of day logic:
	config.SetDaytime(Cyberpunk.GetHour())

	-- begin targetFps logic:
	if not var.settings.enableTargetFps
	or var.settings.mode == var.mode.RTOnly then
		return
	end

	if stats.fps < var.settings.targetFps then
		if var.settings.autoScale > 1 then
			var.settings.autoScale = var.settings.autoScale - 1
			config.AutoScale(var.settings.autoScale)
		end
	else
		if var.settings.autoScale < 6 then
			var.settings.autoScale = var.settings.autoScale + 1
			config.AutoScale(var.settings.autoScale)
		end
	end
end

local function doWeatherUpdate()
	if timer.paused then
		return
	end

	-- if the weather is stuck, change it
	local currentWeather = Cyberpunk.GetWeather()
	if currentWeather == config.PreviousWeather then
		config.BumpWeather(currentWeather)
	end
	config.PreviousWeather = currentWeather
end

registerForEvent('onUpdate', function(delta)
	-- handle non-blocking background tasks
	timer.fast = timer.fast + delta
	timer.lazy = timer.lazy + delta
	timer.weather = timer.weather + delta

	stats.fps = (stats.fps * 9 + (1 / delta)) / 10

	if timer.fast > timer.FAST then
		doFastUpdate()
		timer.fast = 0
	end

	if timer.lazy > timer.LAZY then
		doLazyUpdate()
		timer.lazy = 0
	end

	if timer.weather > timer.WEATHER then
		doWeatherUpdate()
		timer.weather = 0
	end

	for i = #activeTimers, 1, -1 do
		local tempTimer = activeTimers[i]
		tempTimer.countdown = tempTimer.countdown - delta

		if tempTimer.countdown < 0 then
			tempTimer.callback()
			table.remove(activeTimers, i)
		end
	end
end)

local function initUltraPlus()
	logger.info('Initializing...')
	logger.debug('Debug mode active')

	LoadIni('common')
	LoadSettings()

	config.SetGraphics(var.settings.graphics)
	config.SetMode(var.settings.mode)
	config.SetQuality(var.settings.quality)
	config.SetSceneScale(var.settings.sceneScale)
	config.SetVram(var.settings.vram)
	LoadIni('myownsettings')
	-- preparePTNext()
end

registerForEvent('onTweak', function()
	-- load as early as possible to prevent crashes
	LoadIni('common')
	LoadIni('myownsettings')
end)

registerForEvent('onInit', function()

	Observe('QuestTrackerGameController', 'OnUninitialize', function()
		gameSession.active = false
	end)

	ObserveAfter('QuestTrackerGameController', 'OnInitialize', function()
		gameSession.active = true
	end)

	Observe('FastTravelSystem', 'OnUpdateFastTravelPointRecordRequest', function()
		gameSession.fastTravel = true
	end)

	Observe('FastTravelSystem', 'OnPerformFastTravelRequest', function()
		gameSession.fastTravel = true
	end)

	Observe('FastTravelSystem', 'OnLoadingScreenFinished', function(_, finished)
		if finished then
			gameSession.fastTravel = false
		end
	end)

	Observe('gameuiPopupsManager', 'OnMenuUpdate', function(_, isInMenu)
		gameSession.isInMenu = isInMenu
	end)

	Observe('CCTVCamera', 'TakeControl', function(this, val)
		logger.info(string.format('	(Camera control: %s %s)', this, val))
	end)

	ObserveAfter('CCTVCamera', 'TakeControl', function(this, val)
		logger.info(string.format('	(Camera control end: %s %s)', this, val))
	end)

	initUltraPlus()
end)

registerForEvent('onOverlayOpen', function()
	var.window.open = true
	var.ultraPlusActive = true
end)

registerForEvent('onOverlayClose', function()
	var.window.open = false
	doWindowClose()
end)

registerForEvent('onDraw', function()
	if not var.window.open then
		return
	end

	render.renderUI(stats.fps, var.window.open)
end)
