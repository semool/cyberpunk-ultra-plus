-- render.lua

local logger = require("helpers/logger")
local options = require("options")
local var = require("variables")
local color = require("color")
local config = {
	SetMode = require("setmode").SetMode,
	SetQuality = require("setquality").SetQuality,
	SetSceneScale = require("setscenescale").SetSceneScale,
	SetVram = require("setvram").SetVram,
	DEBUG = true,
	fpsText = nil,
}
local window = {
	open = false,
	uiScale = 0.9,
	initialHeight = 0,
	initialWidth = 0,
	sizeMultiplier = 1.0,
	debugHeight = 910,
	gotDimensions = false,
	isDebugTabActive = false,
	filterText = "",
}
local stats = {
	fps = 0,
}
local toggled
local ui = {
	line = function()
		ImGui.Spacing()
		ImGui.Separator()
		ImGui.Spacing()
	end,

	space = function()
		ImGui.Spacing()
	end,

	width = function(px)
		ImGui.SetNextItemWidth(px)
	end,

	align = function()
		ImGui.SameLine()
	end,

	text = function(text)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.Text(text)
		ImGui.PopStyleColor()
	end,

	tab = function(label, func)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.Tab, color.darker)
		ImGui.PushStyleColor(ImGuiCol.TabHovered, color.medium)
		ImGui.PushStyleColor(ImGuiCol.TabActive, color.medium)

		local isOpen = ImGui.BeginTabItem(label)
		ImGui.PopStyleColor(4)

		if isOpen then
			func()
			ImGui.EndTabItem()
		end
	end,

	tabDebug = function(label, func)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.Tab, color.darker)
		ImGui.PushStyleColor(ImGuiCol.TabHovered, color.medium)
		ImGui.PushStyleColor(ImGuiCol.TabActive, color.medium)

		local isOpen = ImGui.BeginTabItem(label)
		ImGui.PopStyleColor(4)

		if isOpen and config.DEBUG then
			func()
			ImGui.EndTabItem()
			window.isDebugTabActive = true
		else
			window.isDebugTabActive = false
		end
	end,

	button = function(label)
		ImGui.PushStyleColor(ImGuiCol.Button, color.darker)
		ImGui.PushStyleColor(ImGuiCol.ButtonHovered, color.dark)
		ImGui.PushStyleColor(ImGuiCol.ButtonActive, color.medium)

		local result = ImGui.Button(label)

		ImGui.PopStyleColor(3)
		return result
	end,

	filter = function(label, text, textBufferSize)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.FrameBg, color.darker)
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, color.dark)
		ImGui.PushStyleColor(ImGuiCol.FrameBgActive, color.medium)
		ImGui.PushStyleColor(ImGuiCol.Button, color.darker)
		ImGui.PushStyleColor(ImGuiCol.ButtonHovered, color.dark)
		ImGui.PushStyleColor(ImGuiCol.ButtonActive, color.medium)
		ImGui.PushStyleColor(ImGuiCol.TextSelectedBg, color.medium)

		local newBuffer = ImGui.InputText(label, text, textBufferSize)

		ImGui.SameLine()	
		if ImGui.Button("Clear") then
			newBuffer = ""
		end

		ImGui.PopStyleColor(8)
		return newBuffer
	end,

	inputInt = function(label, ...)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.FrameBg, color.darker)
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, color.medium)
		ImGui.PushStyleColor(ImGuiCol.FrameBgActive, color.medium)
		ImGui.PushStyleColor(ImGuiCol.Button, color.darker)
		ImGui.PushStyleColor(ImGuiCol.ButtonHovered, color.medium)
		ImGui.PushStyleColor(ImGuiCol.ButtonActive, color.medium)
		ImGui.PushStyleColor(ImGuiCol.TextSelectedBg, color.medium)

		local result, changed = ImGui.InputInt(label, ...)

		ImGui.PopStyleColor(8)
		return result, changed
	end,

	inputFloat = function(label, value)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.FrameBg, color.darker)
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, color.medium)
		ImGui.PushStyleColor(ImGuiCol.FrameBgActive, color.medium)
		ImGui.PushStyleColor(ImGuiCol.TextSelectedBg, color.medium)

		local result, changed = ImGui.InputFloat(label, value)

		ImGui.PopStyleColor(5)
		return result, changed
	end,

	header = function(text)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.Header, color.dark)
		ImGui.PushStyleColor(ImGuiCol.HeaderHovered, color.dark)
		ImGui.PushStyleColor(ImGuiCol.HeaderActive, color.dark)

		local result = ImGui.CollapsingHeader(text, ImGuiTreeNodeFlags.DefaultOpen)

		ImGui.PopStyleColor(4)
		return result
	end,

	radio = function(label, isActive)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.FrameBg, color.darker)
		ImGui.PushStyleColor(ImGuiCol.CheckMark, color.light)
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, color.medium)

		local result = ImGui.RadioButton(label, isActive)

		ImGui.PopStyleColor(4)
		return result
	end,

	checkbox = function(label, value)
		ImGui.PushStyleColor(ImGuiCol.Text, color.text)
		ImGui.PushStyleColor(ImGuiCol.FrameBg, color.darker)
		ImGui.PushStyleColor(ImGuiCol.CheckMark, color.light)
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, color.medium)

		local result, toggled = ImGui.Checkbox(label, value)

		ImGui.PopStyleColor(4)
		return result, toggled
	end,

	tooltip = function(text)
		if ImGui.IsItemHovered() and text ~= "" then
			ImGui.PushStyleColor(ImGuiCol.Text, color.text)
			ImGui.BeginTooltip()
			ImGui.SetTooltip(text)
			ImGui.EndTooltip()
			ImGui.PopStyleColor()
		end
	end,
}

local function renderTabEngineDrawer()
	ui.text("NOTE: Once happy, reload a save to fully activate the mode")

	local renderingModes = {
		{ key = "RASTER", label = "Rast", tooltip = "Configures normal raster, with optimisations and fixes." },
		{ key = "RT", label = "RT", tooltip = "Configures normal ray tracing, with optimisations and fixes." },
		{ key = "RT_PT", label = "RT+PT", tooltip = "Normal raytracing plus path traced bounce lighting. Leave Path Tracing\ndisabled in graphics options for this to work correctly." },
		{ key = "PT16", label = "16", tooltip = "Path tracing from Cyberpunk 1.6x. Requires NRD (disable Ray Reconstruction)" },
		{ key = "PT20", label = "20", tooltip = "Path tracing from Cyberpunk 2.0.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality." },
		{ key = "PT21", label = "21", tooltip = "Path tracing from Cyberpunk 2.10+.\nNOTE: For all PT except PTNext, for the best visuals we recommend higher\nDLSS/FSR/XeSS and lower PT quality." },
		{ key = "PTNEXT", label = "Next", tooltip = "For this mode to work, you MUST load a save game, or start CyberPunk with\nPTNext enabled. Changing graphics/DLSS will also require a reload.\n\nNOTE: For other PT modes we recommend increasing DLSS/FSR3 and lowering PT\nquality for the best visuals. However for PTNext we recommend the opposite:\nRun PTNext as high as you can and turn upscaling down a step." }
	}
	ui.space()
	if ui.header("Rendering Mode                 | PT >") then
		for _, mode in ipairs(renderingModes) do
			local modeValue = var.mode[mode.key]
			if ui.radio(mode.label, var.settings.mode == modeValue) then
				var.settings.mode = modeValue
				config.SetMode(var.settings.mode)
				config.SetQuality(var.settings.quality)
				config.SetSceneScale(var.settings.sceneScale)
				SaveSettings()
			end
			ui.tooltip(mode.tooltip)
			ui.align()
		end
	end

	local qualityOrder = { "VANILLA", "FAST", "MEDIUM", "HIGH", "INSANE" }
	ui.space()
	if ui.header("Quality Level") then
		for _, key in ipairs(qualityOrder) do
			local qualityLabel = var.quality[key] .. "##Quality"
			local qualityValue = var.quality[key]
			if ui.radio(qualityLabel, var.settings.quality == qualityValue) then
				var.settings.quality = qualityValue
				config.SetQuality(var.settings.quality)
				SaveSettings()
			end
			ui.align()
		end
	end

	local sceneScaleOrder = { "PERFORMANCE", "VANILLA", "BALANCED", "QUALITY" }
	ui.space()

	local disableRadianceCache = var.settings.mode == var.mode.RASTER or var.settings.mode == var.mode.RT or var.settings.mode == var.mode.RT_PT or var.settings.mode == var.mode.PT16
	if disableRadianceCache then
		ImGui.BeginDisabled(true)
	end

	if ui.header("Radiance Cache Accuracy") then
		for _, key in ipairs(sceneScaleOrder) do
			local scaleLabel = var.sceneScale[key] .. "##SS"
			local scaleValue = var.sceneScale[key]
			if ui.radio(scaleLabel, var.settings.sceneScale == scaleValue) then
				var.settings.sceneScale = scaleValue
				config.SetSceneScale(var.settings.sceneScale)
				SaveSettings()
			end
			ui.align()
		end
	end

	if disableRadianceCache then
		ImGui.EndDisabled()
	end

	local graphicsOrder = { "POTATO", "FAST", "MEDIUM", "HIGH" }
	ui.space()
	if ui.header("Game Graphics Settings (plus raster tweaks)") then
		for _, key in ipairs(graphicsOrder) do
			local graphicsLabel = var.graphics[key] .. "##Graphics"
			local graphicsValue = var.graphics[key]
			if ui.radio(graphicsLabel, var.settings.graphics == graphicsValue) then
				var.settings.graphics = graphicsValue

				logger.info("Configuring in-game graphics for", var.settings.graphics)
				local iniFilename = "config_graphics_" .. string.lower(key) .. ".ini"
				LoadIni(iniFilename)
				LoadIni("myownsettings.ini")

				SaveSettings()
				PushChanges()
			end
			ui.align()
		end
	end

	ui.space()
	if ui.header("VRAM Configuration (GB)") then
		local vramSorted = {}
		for _, value in pairs(var.vram) do
			table.insert(vramSorted, value)
		end
		table.sort(vramSorted)

		for _, v in ipairs(vramSorted) do
			if ui.radio(tostring(v) .. "##GB", var.settings.vram == v) then
				var.settings.vram = v
				config.SetVram(var.settings.vram)
				SaveSettings()
			end
			ui.align()
		end
	end

	ui.space()
	if ui.header("Tweaks") then
		for _, setting in pairs(options.Tweaks) do
			setting.value = GetOption(setting.category, setting.item)
			setting.value, toggled = ui.checkbox(setting.name, setting.value)
			ui.tooltip(setting.tooltip)

			if toggled then
				SetOption(setting.category, setting.item, setting.value)

				if setting.item == "nsgddCompatible" then
					config.SetVram(var.settings.vram)
				end

				SaveSettings()
			end
		end
	end

	ui.space()
	var.settings.enableConsole, toggled = ui.checkbox("Console", var.settings.enableConsole)
	ui.tooltip("Ultra+ will log what it's doing to the CET console")
	if toggled then
		SaveSettings()
	end

	ImGui.SameLine(190 * window.sizeMultiplier)
	var.settings.enableTargetFps, toggled = ui.checkbox("Enable Target FPS", var.settings.enableTargetFps)
	ui.tooltip("Ultra+ will use basic perceptual auto-scaling of ray/path\tracing quality to target consistent FPS")
	if toggled then
		SaveSettings()
	end

	if var.settings.enableTargetFps then
		ImGui.SameLine(250 * window.sizeMultiplier)
		ui.align()
		ui.width(130 * window.sizeMultiplier)
		var.settings.targetFps, toggled = ui.inputInt("", var.settings.targetFps, 1)

		if toggled then
			SaveSettings()
		end
	end
end

local function renderRenderingFeaturesDrawer()
	ui.space()
	for _, setting in pairs(options.Features) do
		setting.value = GetOption(setting.category, setting.item)
		setting.value, toggled = ui.checkbox(setting.name, setting.value)
		ui.tooltip(setting.tooltip)

		if toggled then
			SetOption(setting.category, setting.item, setting.value)
			SaveSettings()
		end
	end
end

local function renderDebugSettings(setting, inputType, width)
	setting.value = GetOption(setting.category, setting.item)
	ui.width(width or 0)

	if inputType == "Checkbox" then
		setting.value, toggled = ui.checkbox(setting.name, setting.value)
	elseif inputType == "InputInt" then
		setting.value, toggled = ui.inputInt(setting.name, setting.value)
	elseif inputType == "InputFloat" then
		setting.value, toggled = ui.inputFloat(setting.name, tonumber(setting.value))
	end

	ui.tooltip(setting.tooltip)

	if toggled then
		if inputType == "InputFloat" then
			SetOption(setting.category, setting.item, setting.value, "float")
		else
			SetOption(setting.category, setting.item, setting.value)
		end
		SaveSettings()
	end
end

local function renderDebugDrawer()
	local settingGroups = {
		{ options.RTXDI, "Checkbox" },
		{ options.RTXGI, "Checkbox" },
		{ options.REGIR, "Checkbox" },
		{ options.RELAX, "Checkbox" },
		{ options.REBLUR, "Checkbox" },
		{ options.NRD, "Checkbox" },
		{ options.RTOPTIONS, "Checkbox" },
		{ options.SHARC, "Checkbox" },
		{ options.RTINT, "InputInt", 140 * window.sizeMultiplier },
		{ options.RTFLOAT, "InputFloat", 180 }
	}

	-- pin tabs and filter to top
	ui.space()
	ui.text("Filter by:")
	ui.align()
	ImGui.SetNextItemWidth(150 * window.sizeMultiplier)
	window.filterText = ui.filter("##Filter", window.filterText, 100)
	ui.line()

	-- begin scrollable region
	ImGui.BeginChild("SettingsRegion", ImGui.GetContentRegionAvail(), true)

	for _, group in ipairs(settingGroups) do
		local settings, inputType, width = table.unpack(group)
		local hasVisibleItems = false
		for _, setting in pairs(settings) do
			if window.filterText == "" or string.find(string.lower(setting.name), string.lower(window.filterText)) then
				if not hasVisibleItems then
					hasVisibleItems = true
				end
				renderDebugSettings(setting, inputType, width)
			end
		end
		if hasVisibleItems then
			ui.line()
		end
	end
	-- end scrollable region

	ImGui.EndChild()
end

local function renderTabs()
	ImGui.PushStyleColor(ImGuiCol.TabActive, color.dark)

	if ImGui.BeginTabBar("Tabs") then
		ui.tab("Ultra+ Config", renderTabEngineDrawer)
		ui.tab("Rendering Features", renderRenderingFeaturesDrawer)
		ui.tabDebug("Debug", renderDebugDrawer)

		ImGui.EndTabBar()
	end

	ImGui.PopStyleColor()
end

local function renderFps()
	if stats.fps == 0 then
		return
	end

	config.fpsText = string.format("Real FPS: %.0f", stats.fps) -- lazy makeshift round function
	ImGui.SetCursorPosX(380 * window.sizeMultiplier)
	ImGui.SetCursorPosY(42 * window.sizeMultiplier)
	ImGui.Text(config.fpsText)
end

ui.renderUI = function(fps, open)
	stats.fps = fps

	ImGui.PushStyleColor(ImGuiCol.WindowBg, color.bg)
	ImGui.PushStyleColor(ImGuiCol.ChildBg, color.bg)
	ImGui.PushStyleColor(ImGuiCol.Border, color.darker)
	ImGui.PushStyleColor(ImGuiCol.TitleBg, color.bg)
	ImGui.PushStyleColor(ImGuiCol.TitleBgActive, color.bg)
	ImGui.PushStyleColor(ImGuiCol.TitleBgCollapsed, color.bg)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarBg, color.bg)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrab, color.medium)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabHovered, color.mediumer)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabActive, color.mediumer)

	ImGui.SetNextWindowPos(10, 300, ImGuiCond.FirstUseEver)
	if window.isDebugTabActive then
		ImGui.SetNextWindowSize(window.initialWidth, window.debugHeight * window.sizeMultiplier)
	else
		ImGui.SetNextWindowSize(window.initialWidth, window.initialHeight)
	end

	-- begin render
	if ImGui.Begin("Ultra+ v"..UltraPlus.__VERSION, true, ImGuiWindowFlags.NoResize) then
		ImGui.SetWindowFontScale(var.settings.uiScale)

		if open and not window.gotDimensions and ImGui.GetWindowHeight() > 200 then
			window.initialHeight = ImGui.GetWindowHeight() + 1
			window.initialWidth = ImGui.GetWindowWidth()
			window.sizeMultiplier = window.initialWidth / 512
			window.gotDimensions = true
		end

		renderTabs()
		renderFps()

		ImGui.End()
		ImGui.PopStyleColor(10)
	end
end

return ui