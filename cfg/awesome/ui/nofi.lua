local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local nofi = {}

naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = 0
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 10
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = 20
naughty.config.defaults.position = "top_right"
naughty.config.defaults.border_width = 5
naughty.config.defaults.border_color = "#eaecf2"
naughty.config.defaults.font = "uzura_font 10"
naughty.config.defaults.width = 300

-- Function to show notifications
function nofi.show(title, text, icon)
    local close_button = wibox.widget {
        text = "Close",
        align = "center",
        widget = wibox.widget.textbox,
    }

    -- Set a fixed width for the close button
    close_button:set_forced_width(80)

    -- Add padding around the button
    local button_container = wibox.container.margin(close_button, 10, 10, 10, 10)

    local notification = naughty.notify({
        title = title or naughty.config.defaults.title,
        text = text or "",
        icon = icon or nil,
        timeout = 10,
        screen = naughty.config.defaults.screen,
        border_color = naughty.config.defaults.border_color,
        border_width = naughty.config.defaults.border_width,
        font = naughty.config.defaults.font,
        width = naughty.config.defaults.width,
        position = naughty.config.defaults.position,
        margin = naughty.config.defaults.margin,
        widget = wibox.widget {
            {
                text = text or "",
                widget = wibox.widget.textbox,
                align = "center",
                forced_width = naughty.config.defaults.width - 20,  -- Adjusting for margins
            },
            button_container,
            layout = wibox.layout.fixed.vertical,
        },
    })

    -- Connect the close button signal
    button_container:buttons(gears.table.join(
        awful.button({}, 1, function()
            naughty.destroy(notification)
        end)
    ))
end

return nofi

