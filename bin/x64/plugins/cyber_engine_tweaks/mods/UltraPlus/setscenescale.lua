-- setscenescale.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local Cyberpunk = require('helpers/Cyberpunk')
local config = {}

function config.SetSceneScale(scale)
	logger.info('Settings SceneScale to', scale)

	if scale == var.sceneScale.FAST then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '30.0')
		return
	end

	if scale == var.sceneScale.VANILLA then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '50.0')
		return
	end

	if scale == var.sceneScale.MEDIUM then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '100.0')
		return
	end

	if scale == var.sceneScale.HIGH then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '200.0')
		return
	end

	if scale == var.sceneScale.INSANE then
		Cyberpunk.SetOption('Editor/SHARC', 'SceneScale', '400.0')
		return
	end
end

return config
