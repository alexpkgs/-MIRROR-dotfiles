local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gfs = require("gears.filesystem")

local nofi = {}

-- Set default notification configurations
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = 0
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 10  -- Set default timeout to 10 seconds
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = 20  -- Margin around the notification
naughty.config.defaults.position = "top_left"
naughty.config.defaults.border_width = 5
naughty.config.defaults.border_color = "#eaecf2"
naughty.config.defaults.font = "Cartograph CF 10"
naughty.config.defaults.width = 300

-- Function to show notifications
function nofi.show(title, text, icon)
    naughty.notify({
        title = title or naughty.config.defaults.title,
        text = text or "",
        icon = icon or nil,
        timeout = 10,  -- Set timeout to 10 seconds
        screen = naughty.config.defaults.screen,
        border_color = naughty.config.defaults.border_color,
        border_width = naughty.config.defaults.border_width,
        font = naughty.config.defaults.font,
        width = naughty.config.defaults.width,
        position = naughty.config.defaults.position,
        margin = naughty.config.defaults.margin,  -- Maintain margin for spacing
    })
end

return nofi

