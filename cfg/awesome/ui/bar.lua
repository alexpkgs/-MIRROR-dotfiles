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

-- Create a text widget for the title
local function create_title_widget()
    local title_widget = wibox.widget.textbox()
    title_widget.font = "uzura_font"
    
    -- Update the title widget when the focus changes
    client.connect_signal("focus", function(c)
        title_widget.text = c.name or "Untitled"
    end)

    -- Clear the title when unfocused
    client.connect_signal("unfocus", function()
        title_widget.text = ""
    end)

    return title_widget
end

-- Create a text widget for the time
local function create_time_widget()
    local time_widget = wibox.widget.textclock("%I:%M")  -- 12-hour format
    time_widget.font = "uzura_font"
    return time_widget
end

-- Create the wibox (bar)
local function create_bar(s)
    local mywibox = awful.wibar({
        position = "bottom",
        screen = s,
        width = 1000,
        height = 30,
        bg = beautiful.bg_normal,
        ontop = true,
        floating = true,
    })

    local layout = wibox.layout.align.horizontal()

    -- Add the logo to the left
    local logo = create_logo_button()
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(logo)

    -- Create the title widget for the center
    local title_widget = create_title_widget()
    local center_layout = wibox.layout.flex.horizontal()
    center_layout:add(title_widget)

    -- Create the time widget for the right
    local time_widget = create_time_widget()

    -- Set the layouts
    layout:set_left(left_layout)
    layout:set_middle(center_layout)  -- Center the title widget
    layout:set_right(time_widget)      -- Time widget on the right

    -- Set the layout for the wibox
    mywibox:set_widget(layout)

    -- Position the wibox manually to the bottom with a slight offset
    local offset = 10
    mywibox:geometry({ y = s.geometry.height - mywibox.height - offset })
end

return create_bar

