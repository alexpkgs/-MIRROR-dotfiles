local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local function create_bar(s)
    -- Create the wibox at the left with a border
    s.mywibox = awful.wibar({
        position = "left",
        screen = s,
        width = 20,  -- Adjust width as needed
        bg = "#00000000",  -- Transparent background
        border_color = "#1f1104",  -- Border color
        border_width = 4,  -- Border width
    })

    -- Add an empty setup to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.vertical,
        nil, -- Top widget (none)
        nil, -- Middle widget (none)
        nil, -- Bottom widget (none)
    }
end

return create_bar
