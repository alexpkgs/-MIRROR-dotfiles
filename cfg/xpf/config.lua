-- Configuration for system information display

local Config = {}

-- Function to return the default configuration
function Config.DefaultConfig()
    return {
        ShowOS = true,
        ShowShell = true,
        ShowTerminal = false,
        ShowWM = true,
    }
end

return Config


