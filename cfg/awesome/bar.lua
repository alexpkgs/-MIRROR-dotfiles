local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")


local function create_logo_button()
    local logo = wibox.widget {
        image = gears.filesystem.get_configuration_dir() .. "icons/awesome.png",
        resize = true,
        widget = wibox.widget.imagebox,
    }

    logo:buttons(gears.table.join(
        awful.button({}, 1, function() awful.spawn("rofi -show drun") end)
    ))

    return logo
end

-- Create a text widget for the time
local function create_time_widget()
    local time_widget = wibox.widget.textclock("%I:%M" )  -- 12-hour format
    time_widget.font = "Cartograph 10"
    return time_widget
end

-- Create a title widget for the focused client
local function create_title_widget()
    local title_widget = wibox.widget {
        text = "No window focused",  -- Default text
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    -- Update the title when the focused client changes
    client.connect_signal("focus", function(c)
        title_widget.text = c.name or "No window focused"
    end)

    return title_widget
end

-- Create the wibox (bar)
local function create_bar(s)
    local mywibox = awful.wibar({
        position = "bottom",
        screen = s,
        width = 800,
        bg = beautiful.bg_normal,
        ontop = true,
        floating = true,
    })

    local layout = wibox.layout.align.horizontal()

    -- Add the logo to the left
    local logo = create_logo_button()
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(logo)

    -- Create the title widget and add it to the center
    local title_widget = create_title_widget()
    layout:set_middle(title_widget)  -- Set title widget directly in the center

    -- Add the time widget to the right
    local time_widget = create_time_widget()
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(time_widget)

    -- Set the layouts
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    -- Set the layout for the wibox
    mywibox:set_widget(layout)

    -- Position the wibox manually to the bottom with a slight offset
    local offset = 10
    mywibox:geometry({ y = s.geometry.height - mywibox.height - offset })
end

return create_bar
