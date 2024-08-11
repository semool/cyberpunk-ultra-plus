-- setgraphics.lua

Logger = require('helpers/Logger')
Var = require('helpers/Variables')
Config = {}
Cyberpunk = require('helpers/Cyberpunk')

function Config.SetGraphics(graphics)
	Logger.info('Setting game graphics for', graphics)

	if graphics == Var.graphics.HIGH then
		LoadIni('graphics_high')
		return
	end

	if graphics == Var.graphics.MEDIUM then
		LoadIni('graphics_medium')
		return
	end

	if graphics == Var.graphics.LOW then
		LoadIni('graphics_low')
		return
	end

	if graphics == Var.graphics.POTATO then
		LoadIni('graphics_potato')
		return
	end
end

return Config
