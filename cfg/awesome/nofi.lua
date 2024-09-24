local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")  -- Required for timer

local nofi = {}

function nofi.show(title, message)
    -- Ensure title and message are not nil
    title = title or "Notification"
    message = message or "wheres the message"

    -- Create the notification
    local notification = naughty.notify({
        title = title,
        text = message,
        timeout = 5,  -- Notification will disappear after 5 seconds
        hover_timeout = 0.5,  -- Duration of hover to keep it on screen
        width = 300,  -- Width of the notification
        icon = "/path/to/your/icon.png",  -- Optional: set an icon
        preset = naughty.config.presets.normal,
        position = "bottom_right",  -- Start from top right for initial placement
        screen = awful.screen.focused().index,  -- Show on the focused screen
        bg = "#eaecf2",  -- Background color (optional)
        fg = "#685c56",  -- Text color (optional)
        border_color = "#FFFFFF",  -- Optional border color
        border_width = 0,  -- Optional border width
        actions = {
            ["Close"] = function()
                nofi.close_with_animation(notification)
            end,
        },
    })

    -- Adjust position to center top after creation
    if notification then
        local screen_geometry = awful.screen.focused().geometry
        notification.x = screen_geometry.x + (screen_geometry.width / 2) - (notification.width / 2)
        notification.y = screen_geometry.y + 15  -- 10 pixels from the top
    end
end

function nofi.close_with_animation(notification)
    if notification then
        -- Start fade-out animation
        local fade_out_duration = 0.5  -- Duration of fade-out in seconds
        local step_interval = 0.05  -- Time between each step
        local steps = fade_out_duration / step_interval

        for step = 1, steps do
            gears.timer.start_new(step_interval * step, function()
                local alpha = 1 - (step / steps)
                notification.fg = gears.color({ rgba = { 104, 92, 86, 255 * alpha } })
                notification.bg = gears.color({ rgba = { 234, 236, 242, 255 * alpha } })

                if step == steps then
                    naughty.destroy(notification)
                end
                return false  -- Don't repeat the timer
            end)
        end
    end
end

return nofi

