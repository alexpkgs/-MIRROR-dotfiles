local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local nofi = {}

naughty.config.defaults.ontop = true
naughty.config.defaults.position = "top_left"  -- Changed to top_left
naughty.config.defaults.icon_size = 0
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 5.5
naughty.config.defaults.title = "You Got Mailed"
naughty.config.defaults.margin = 20
naughty.config.defaults.border_width = 2
naughty.config.defaults.border_color = "#eaecf2"
naughty.config.defaults.font = "Cartograph CF 9"
naughty.config.defaults.width = 300

-- Function to show notifications
function nofi.show(title, text, icon)
    local close_button = wibox.widget {
        text = "Close",
        align = "center",
        widget = wibox.widget.textbox,
    }

    close_button:set_forced_width(80)
    local button_container = wibox.container.margin(close_button, 10, 10, 10, 10)

    local progressbar = wibox.widget.progressbar()
    progressbar:set_max_value(naughty.config.defaults.timeout)
    progressbar:set_value(naughty.config.defaults.timeout)

    -- Create the notification
    local notification = naughty.notify({
        title = title or naughty.config.defaults.title,
        text = text or "",
        icon = icon or nil,
        timeout = naughty.config.defaults.timeout,
        screen = naughty.config.defaults.screen,
        border_color = naughty.config.defaults.border_color,
        border_width = naughty.config.defaults.border_width,
        font = naughty.config.defaults.font,
        width = naughty.config.defaults.width,
        position = "top_left",  -- Set position to top_left
        margin = naughty.config.defaults.margin,
        widget = wibox.widget {
            {
                {
                    text = title or naughty.config.defaults.title,
                    widget = wibox.widget.textbox,
                    align = "center",
                    forced_width = naughty.config.defaults.width - 20,
                },
                {
                    text = text or "",
                    widget = wibox.widget.textbox,
                    align = "center",
                    forced_width = naughty.config.defaults.width - 20,
                },
                button_container,
                progressbar,
                layout = wibox.layout.fixed.vertical,
            },
            layout = wibox.container.margin,
            left = 40,
            right = 40,
            top = 40,
            bottom = 40,
        },
    })

    -- Manually position the notification in the top left and make it float
    gears.timer.start_new(0.1, function()
        if notification then
            local screen_geom = awful.screen.focused().geometry
            local margin = 20  -- Adjust this value for more space

            notification:geometry({
                x = screen_geom.x + margin,  -- Offset from the left
                y = screen_geom.y + margin,  -- Offset from the top
            })
        end
    end)

    -- Update the progress bar over the timeout duration
    local total_time = naughty.config.defaults.timeout
    local update_interval = 0.1
    local elapsed = 0

    gears.timer.start_new(update_interval, function()
        elapsed = elapsed + update_interval
        progressbar:set_value(total_time - elapsed)

        if elapsed >= total_time then
            naughty.destroy(notification)
            return false  -- Stop the timer
        end

        return true  -- Continue the timer
    end)

    -- Connect the close button signal
    button_container:buttons(gears.table.join(
        awful.button({}, 1, function()
            naughty.destroy(notification)
        end)
    ))
end

return nofi
