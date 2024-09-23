local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Define titlebar colors
local titlebar_colors = {
    background = "#eaecf2",  -- Titlebar background color
    foreground = "#eaecf2",  -- Titlebar text color
}

local function create_titlebar(c)
    local titlebar = awful.titlebar(c, { size = 25 })

    local right_layout = wibox.layout.fixed.horizontal()

    -- Close button
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
        layout = wibox.layout.flex.horizontal,
    }
    right_layout:add(close_button)

    -- Exit button using an icon
    local exit_button = wibox.widget {
        image = gears.filesystem.get_configuration_dir() .. "icons/exit.png",  -- Path to your icon
        resize = true,
        widget = wibox.widget.imagebox,
    }
    exit_button:buttons(gears.table.join(
        awful.button({}, 1, function() c:kill() end)  -- Close the application
    ))

    right_layout:add(exit_button)

    -- Set titlebar colors
    titlebar.bg = titlebar_colors.background
    titlebar.fg = titlebar_colors.foreground

    -- Set the layout for the titlebar
    titlebar:setup {
        layout = wibox.layout.align.horizontal,
        right = right_layout,
    }

    -- Center the client on spawn
    c:emit_signal("request::activate", "titlebar", {raise = true})
end

return create_titlebar
