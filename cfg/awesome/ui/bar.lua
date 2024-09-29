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

-- why time
local function create_time_widget()
    local time_widget = wibox.widget.textclock("%I:%M EST")  -- 12-hour format
    time_widget.font = "Cartograph CF 10"
    return time_widget
end

-- stop using wibox you stupid head
local function create_bar(s)
    local mywibox = awful.wibar({
        position = "left",
        screen = s,
        width = 120,
        height = 30,
        bg = beautiful.bg_normal,
        ontop = false,  -- Set to false so it can be covered by other windows
        floating = true,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 0)  -- Adjust the radius here
        end,
    })

    local layout = wibox.layout.align.horizontal()

    -- Add a spacer to the left
    local spacer = wibox.widget {
        forced_width = 15,  -- Adjust this value for more or less space
        widget = wibox.widget.textbox
    }

    -- Create the logo button
    local logo = create_logo_button()
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(spacer)  -- Add spacer to the left layout
    left_layout:add(logo)

    -- Create the time widget for the right
    local time_widget = create_time_widget()

    -- Set the layouts
    layout:set_left(left_layout)
    layout:set_right(time_widget)  -- Time widget on the right

    -- Set the layout for the wibox
    mywibox:set_widget(layout)

    -- Position the wibox manually to the bottom with a slight offset
    local offset = 15
    mywibox:geometry({ y = s.geometry.height - mywibox.height - offset })

    -- Hide the wibox when a client overlaps
    client.connect_signal("property::floating", function(c)
        if c.floating then
            mywibox.visible = false
        else
            mywibox.visible = true
        end
    end)

    -- Optionally, hide the wibox when focused on a fullscreen client
    client.connect_signal("property::fullscreen", function(c)
        if c.fullscreen then
            mywibox.visible = false
        else
            mywibox.visible = true
        end
    end)
end

-- Return the create_bar function
return create_bar
