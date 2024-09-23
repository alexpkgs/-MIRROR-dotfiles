local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

-- Create an AwesomeWM logo button
local function create_logo_button()
    local logo = wibox.widget {
        image = gears.filesystem.get_configuration_dir() .. "icons/awesome.png",  -- Corrected path
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
    local time_widget = wibox.widget.textclock("%I:%M")  -- 12-hour format
    time_widget.font = "Cartograph 10"  -- Change font size as needed
    return time_widget
end

-- Create the wibox (bar)
local function create_bar(s)
    -- Create a wibox for the screen, floating at the specified position
    local mywibox = awful.wibar({
        position = "bottom",
        screen = s,
        width = 700,
        bg = beautiful.bg_normal,
        ontop = true,  -- Keep the bar above other windows
        floating = true,  -- Set the bar to be floating
    })

    -- Create a layout for the wibox
    local layout = wibox.layout.align.horizontal()

    -- Add the logo to the left
    local logo = create_logo_button()
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(logo)

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
    local offset = 10  -- Adjust this value for more or less floating
    mywibox:geometry({ y = s.geometry.height - mywibox.height - offset })  -- Set the y position to the bottom with an offset
end

return create_bar
