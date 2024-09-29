local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")  -- Ensure you have naughty for notifications

-- Define the nofi function (replace this with your actual implementation)
local nofi = {
    show = function(message)
        naughty.notify({ text = message })  -- Example notification
    end
}

local function create_logo_button()
    local logo = wibox.widget {
        image = gears.filesystem.get_configuration_dir() .. "icons/awesome.png",  -- Your AwesomeWM image
        resize = true,
        widget = wibox.widget.imagebox,
    }

    logo:buttons(gears.table.join(
        awful.button({}, 1, function() 
            nofi.show("Welcome To AwesomeWM, alexshed..") 
        end)
    ))

    return logo
end

-- Create a time widget
local function create_time_widget()
    local time_widget = wibox.widget.textclock("%I:%M EST")  -- 12-hour format
    time_widget.font = "Cartograph CF 10"
    return time_widget
end

-- Create the bar
local function create_bar(s)
    local mywibox = awful.wibar({
        position = "left",
        screen = s,
        width = 120,
        height = 30,
        bg = beautiful.bg_normal,
        ontop = false, -- yay
        floating = true,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 0)  -- Adjust the radius here
        end,
    })

    local layout = wibox.layout.align.horizontal()

    -- spacing bar
    local spacer = wibox.widget {
        forced_width = 15,  -- Adjust.
        widget = wibox.widget.textbox
    }

    
    local logo = create_logo_button()
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(spacer)  
    left_layout:add(logo)

    
    local time_widget = create_time_widget()


    layout:set_left(left_layout)
    layout:set_right(time_widget)  -

    -- layout of wibar
    mywibox:set_widget(layout)

    -- pos of the wibox
    local offset = 15
    mywibox:geometry({ y = s.geometry.height - mywibox.height - offset })

    -- hide smth
    client.connect_signal("property::floating", function(c)
        mywibox.visible = not c.floating
    end)

    -- uh
    client.connect_signal("property::fullscreen", function(c)
        mywibox.visible = not c.fullscreen
    end)
end

-- wdym
return create_bar
