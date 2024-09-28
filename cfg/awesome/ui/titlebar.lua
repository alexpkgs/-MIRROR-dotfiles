local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Define titlebar colors
local titlebar_colors = {
    background = "#ffffff",  -- Titlebar background color (white)
    foreground = "#000000",  -- Titlebar text color (black)
}

local function create_titlebar(c)
    local titlebar = awful.titlebar(c, { size = 35, position = "left" })  -- Positioning the titlebar on the left

    local left_layout = wibox.layout.fixed.vertical()  -- Vertical layout for the left side

    -- Exit button at the top using an icon
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
    left_layout:add(title_widget)

    -- Close button at the bottom
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
    left_layout:add(close_button)

    -- Set titlebar colors
    titlebar.bg = titlebar_colors.background
    titlebar.fg = titlebar_colors.foreground

    -- Set the layout for the titlebar
    titlebar:setup {
        layout = left_layout,  -- Use the vertical layout for the left side
    }

    -- Center the client on spawn
    c:emit_signal("request::activate", "titlebar", {raise = true})
end

return create_titlebar

