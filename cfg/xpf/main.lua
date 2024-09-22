-- ASCII Art for Tux
local tuxLogo = [[
      ___
     (. ·|
     (<> |
    / __  \
   ( /  \ /|
  _/\ __)/_)
  \/-____\/
]]

-- Function to execute a shell command and return its output
local function execCommand(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end

-- Function to retrieve the OS name
local function checkOS()
    local osRelease = execCommand("cat /etc/os-release 2>/dev/null")
    for line in osRelease:gmatch("[^\n]+") do
        if line:match("^NAME=") then
            return line:match('="?(.*)"?') or "Unknown OS"
        end
    end
    return "Unknown OS"
end

-- Function to retrieve the shell being used
local function checkShell()
    return execCommand("basename $SHELL"):match("^%s*(.-)%s*$") -- Trim whitespace
end

-- Function to retrieve the terminal type
local function checkTerminal()
    return (os.getenv("TERM") or "Unknown Terminal"):match("^%s*(.-)%s*$") -- Trim whitespace
end

-- Function to retrieve the window manager
local function checkWindowManager()
    return (os.getenv("XDG_CURRENT_DESKTOP") or "Unknown Window Manager"):match("^%s*(.-)%s*$") -- Trim whitespace
end

-- Function to print the label and value
local function printInfo(label, value)
    print(label .. ": " .. value)
end

-- Require the config module
local Config = require("config")

-- Main function
local function main()
    -- Load the default configuration
    local config = Config.DefaultConfig()

    -- Display the Tux logo at the top
    print(tuxLogo)

    -- Check and print system information based on the configuration
    if config.ShowOS then
        printInfo("os", checkOS())
    end
    if config.ShowShell then
        printInfo("sh", checkShell())
    end
    if config.ShowTerminal then
        printInfo("te", checkTerminal())
    end
    if config.ShowWM then
        printInfo("wm", checkWindowManager())
    end
end

-- Run the main function
main()


