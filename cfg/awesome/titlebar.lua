local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Define titlebar colors
local titlebar_colors = {
    background = "#ffffff",  -- Titlebar background color (white)
    foreground = "#000000",  -- Titlebar text color (black)
}

local function create_titlebar(c)
    local titlebar = awful.titlebar(c, { size = 35 })  -- Size of the titlebar

    local left_layout = wibox.layout.fixed.horizontal()  -- Use horizontal layout for the left side
    local right_layout = wibox.layout.fixed.horizontal()  -- Use horizontal layout for the right side
    local center_layout = wibox.layout.flex.horizontal()  -- Center layout for the title

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

    -- Center title widget
    local title_widget = wibox.widget {
        text = c.name or "Untitled",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }
    -- Update the title when the client name changes
    c:connect_signal("property::name", function()
        title_widget.text = c.name or "Untitled"
    end)
    center_layout:add(title_widget)

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
        layout = wibox.layout.fixed.horizontal,
    }
    right_layout:add(close_button)

    -- Set titlebar colors
    titlebar.bg = titlebar_colors.background
    titlebar.fg = titlebar_colors.foreground

    -- Set the layout for the titlebar
    titlebar:setup {
        layout = wibox.layout.align.horizontal,  -- Use horizontal alignment
        left = left_layout,
        middle = center_layout,  -- Center the title
        right = right_layout,
    }

    -- Center the client on spawn
    c:emit_signal("request::activate", "titlebar", {raise = true})
end

return create_titlebar

