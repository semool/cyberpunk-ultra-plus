-- logger.lua

local __log = function(level)
    return function(...)
        print("          Ultra+:", ...)
    end
end

local logger = {
    info = __log("info")
}

return logger
