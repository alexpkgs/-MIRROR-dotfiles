local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Define titlebar colors
local titlebar_colors = {
    background = "#000000",  -- Titlebar background color (white)
    foreground = "#000000",  -- Titlebar text color (black)
}

local function create_titlebar(c)
    -- Create the titlebar
    local titlebar = awful.titlebar(c, { size = 30, position = "right" })

    -- Exit button using the "X" icon
    local exit_button = wibox.widget.imagebox(gears.filesystem.get_configuration_dir() .. "icons/close.png")  -- Path to your "X" icon
    exit_button:buttons(gears.table.join(
        awful.button({}, 1, function() c:kill() end)  -- Close the application
    ))

    -- Create a horizontal layout for the exit button
    local title_layout = wibox.layout.align.horizontal()
    title_layout:set_right(wibox.container.margin(exit_button, 5, 5, 5, 5))  -- Place the exit button on the right

    -- Set titlebar colors
    titlebar.bg = titlebar_colors.background
    titlebar.fg = titlebar_colors.foreground

    -- Apply the layout to the titlebar
    titlebar:setup {
        layout = wibox.layout.fixed.horizontal,
        title_layout
    }

    -- Handle focused/unfocused state
    c:connect_signal("focus", function()
        titlebar.bg = titlebar_colors.background  -- Keep background white when focused
        titlebar.fg = titlebar_colors.foreground  -- Keep text color black when focused
    end)

    c:connect_signal("unfocus", function()
        titlebar.bg = titlebar_colors.background  -- Keep background white when unfocused
        titlebar.fg = titlebar_colors.foreground  -- Keep text color black when unfocused
    end)

    -- Center the client on spawn
    c:emit_signal("request::activate", "titlebar", { raise = true })
end

-- Connect the titlebar function to client creation
client.connect_signal("request::titlebars", create_titlebar)

return create_titlebar
