-- helpers/config.lua

local config = {
	status = 'Ready.',
	SetMode = require('setmode').SetMode,
	SetQuality = require('setquality').SetQuality,
	SetSceneScale = require('setscenescale').SetSceneScale,
	SetDLSS = require('setdlss').SetDLSS,
	SetVram = require('setvram').SetVram,
	SetGraphics = require('setgraphics').SetGraphics,
	AutoScale = require('perceptualautoscale').AutoScale,
	SetDaytime = require('helpers/daytimetasks').SetDaytime,
	SaveMenu = require('savemenu').SaveMenu,
	BumpWeather = require('bumpweather').BumpWeather,
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