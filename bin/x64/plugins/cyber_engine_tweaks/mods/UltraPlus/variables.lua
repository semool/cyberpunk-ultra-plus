-- variables.lua

local var = {
	mode = {
		VANILLA = "Vanilla",
		PT20 = "PT20",
		PT21 = "PT21",
		PTNEXT = "PTNext",
		RT_PT = "RTPT",
		RT_ONLY = "RTOnly",
		RASTER = "Raster",
	},
	quality = {
		VANILLA = "Vanilla",
		LOW = "Low",
		MEDIUM = "Medium",
		HIGH = "High",
		INSANE = "Insane",
	},
	vram = {
		GB4 = 4,
		GB6 = 6,
		GB8 = 8,
		GB10 = 10,
		GB12 = 12,
		GB16 = 16,
		GB20 = 20,
		GB24 = 24,
	},
	downScale = {
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
		[6] = 6,
		[7] = 7,
	},
	sceneScale = {
		LOW = "Low",
		VANILLA = "Vanilla",
		MEDIUM = "Medium",
		HIGH = "High",
		INSANE = "Insane",
	},
	settings = {
		uiScale = 0.88,
		mode = "Unknown",
		quality = "Unknown",
		sceneScale = 1,
		downScale = 6,
		vram = "Unknown",
		nsgddCompatible = nil,
		indoors = nil,
		rain = nil,
		nrdEnabled = nil,
		enableTargetFps = false,
		targetFps = 30,
		enableConsole = false,
	},
}

return var
