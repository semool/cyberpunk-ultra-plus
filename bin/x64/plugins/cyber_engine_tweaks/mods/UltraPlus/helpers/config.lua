-- helpers/config.lua

local config = {
	status = 'Ready.',
	SetMode = require('helpers/setmode').SetMode,
	SetQuality = require('helpers/setquality').SetQuality,
	SetSceneScale = require('helpers/setscenescale').SetSceneScale,
	SetDLSS = require('helpers/setdlss').SetDLSS,
	SetVram = require('helpers/setvram').SetVram,
	SetGraphics = require('helpers/setgraphics').SetGraphics,
	AutoScale = require('helpers/perceptualautoscale').AutoScale,
	SetDaytime = require('helpers/daytimetasks').SetDaytime,
	SaveMenu = require('helpers/savemenu').SaveMenu,
	BumpWeather = require('helpers/bumpweather').BumpWeather,
	ptNext = {
		active = false,
		stage1 = false,
		stage2 = false,
	},
	gameSession = {
		active = false,
		isInMenu = false,
		fastTravel = false,
		lastTime = 0,
		previousWeather = nil,
	},
}

return config
