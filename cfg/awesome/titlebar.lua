local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Define titlebar colors
local titlebar_colors = {
    background = "#ffffff",  -- Titlebar background color (white)
    foreground = "#ffffff",  -- Titlebar text color (white)
}

local function create_titlebar(c)
    local titlebar = awful.titlebar(c, { size = 25, position = "left" })  -- Set position to left

    local left_layout = wibox.layout.fixed.vertical()  -- Use vertical layout for the left side
    local right_layout = wibox.layout.fixed.vertical()  -- Use vertical layout for the right side

    -- Exit button on the left side using an icon
    local exit_button = wibox.widget {
        image = "./icons/exit.png",  -- Path to your icon
        resize = true,
        widget = wibox.widget.imagebox,
    }
    exit_button:buttons(gears.table.join(
        awful.button({}, 1, function() c:kill() end)  -- Close the application
    ))
    left_layout:add(exit_button)

    -- Close button on the right side
    local close_button = wibox.widget {
        {
            text = "X",
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        buttons = gears.table.join(
            awful.button({}, 1, function() c:kill() end)  -- Close the application
        ),
        layout = wibox.layout.fixed.vertical,
    }
    right_layout:add(close_button)

    -- Set titlebar colors
    titlebar.bg = titlebar_colors.background
    titlebar.fg = titlebar_colors.foreground

    -- Set the layout for the titlebar
    titlebar:setup {
        layout = wibox.layout.align.vertical,  -- Change to vertical alignment
        left = left_layout,
        right = right_layout,
    }

    -- Center the client on spawn
    c:emit_signal("request::activate", "titlebar", {raise = true})
end

return create_titlebar
