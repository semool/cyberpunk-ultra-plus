-- helpers/daytimetasks.lua

local logger = require('helpers/logger')
local var = require('helpers/variables')
local config = {}

function config.SetDaytime(hour)
	if hour ~= config.PreviousHour then
		local timeDescription = (hour == 6) and 'dawn' or (hour == 18) and 'dusk' or (hour == 12) and 'midday' or (hour == 20) and 'night time' or string.format('%02d:00', hour)
		logger.info(string.format('    (Doing daytime tasks for: %s)', timeDescription))

		local sunAngularSize = var.SunAngularSizes[hour]
		if sunAngularSize then
			Cyberpunk.SetOption('RayTracing', 'SunAngularSize', sunAngularSize)
		end
	end

	config.PreviousHour = hour
end

return config
