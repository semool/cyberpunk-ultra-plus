-- helpers/Config.lua

local Config = {
	status = 'Ready.',
	ptNext = {
		active = false,
		stage1 = false,
		stage2 = false,
	},
	gameSession = {
		gameSessionActive = false,
		gameMenuActive = false,
		photoModeActive = false,
		tutorialActive = false,
		fastTravelActive = false,
		lastTime = 0,
		previousWeather = nil,
	},
}

return Config
