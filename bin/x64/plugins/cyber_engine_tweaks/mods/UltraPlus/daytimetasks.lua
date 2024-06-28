-- daytimetasks.lua

local logger = require("logger")
local var = require("variables")
local config = {
	SunAngularSizes = {
		[0] = "0.4",
		[1] = "0.4",
		[2] = "0.4",
		[3] = "0.4",
		[4] = "0.4",
		[5] = "0.4",
		[6] = "0.375",
		[7] = "0.35",
		[8] = "0.325",
		[9] = "0.3",
		[10] = "0.275",
		[11] = "0.25",
		[12] = "0.225",
		[13] = "0.225",
		[14] = "0.25",
		[15] = "0.275",
		[16] = "0.3",
		[18] = "0.325",
		[19] = "0.35",
		[20] = "0.375",
		[21] = "0.4",
		[22] = "0.4",
		[23] = "0.4",
		PreviousHour = -1,
	},
}

function config.SetDaytime(hour)
	if hour ~= config.PreviousHour then
		local timeDescription = (hour == 6) and "dawn" or (hour == 18) and "dusk" or (hour == 12) and "midday" or (hour == 20) and "night time" or string.format("%02d:00", hour)
        logger.info(string.format("    (Doing daytime tasks for: %s)", timeDescription))

        local sunAngularSize = config.SunAngularSizes[hour]
        if sunAngularSize then
            SetOption("RayTracing", "SunAngularSize", sunAngularSize)
        end
	end

	config.PreviousHour = hour
end

return config
