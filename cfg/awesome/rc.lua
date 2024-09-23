-- If LuaRocks is installed, make sure that packages installed through it are found (e.g. lgi).
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local create_bar = require("bar")
local create_titlebar = require("titlebar")  -- Ensure this is required
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library
local naughty = require("naughty") -- Notification library
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Error handling
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-- Variable definitions
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

terminal = "wezterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
require("nofi")
-- Menu configuration
local myawesomemenu = {
    { "hotkeys", function() awful.hotkeys.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

local mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal },
    }
})

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Create a custom bar
local create_bar = require("bar")

-- Function to set the wallpaper
local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- Connect to screens and set up workspaces and bar
awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    -- Define tags (workspaces)
    local tags = { "1", "2", "3", "4", "5" }
    awful.tag(tags, s)

    create_bar(s)  -- Create the bar after defining tags

    -- Right-click to show the menu
    root.buttons(gears.table.join(
        awful.button({}, 3, function() mymainenu:show() end) -- Right-click
    ))
end)

-- Global key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "Left", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "Right", awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey }, "Tab", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey }, "w", function() mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Standard program
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    -- Shortcut for Flameshot GUI
    awful.key({ modkey }, "s", function() awful.spawn("flameshot gui") end,
              {description = "take a screenshot", group = "launcher"}),

    -- Launch Rofi with mod + d
    awful.key({ modkey }, "d", function() awful.spawn("rofi -show drun") end,
              {description = "launch Rofi application launcher", group = "launcher"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
              {description = "quit awesome"}),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end, {description = "restore minimized", group = "client"}),

    -- New keybinding for quitting the focused app
    awful.key({ modkey }, "q", function()
        if client.focus then client.focus:kill() end
    end, {description = "close the focused client", group = "client"})
)

-- Client key bindings
clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey }, "t", function(c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey }, "n", function(c) c.minimized = true end,
              {description = "minimize", group = "client"}),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, {description = "(un)maximize", group = "client"})
)

-- Bind all key numbers to tags.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then tag:view_only() end
                  end, {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then awful.tag.viewtoggle(tag) end
                  end, {description = "toggle tag #" .. i, group = "tag"}),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then client.focus:move_to_tag(tag) end
                      end
                  end, {description = "move focused client to tag #"..i, group = "tag"})
    )
end

-- Client mouse bindings
clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients
awful.rules.rules = {
    { rule = {},
      properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus = awful.client.focus.filter,
          raise = true,
          keys = clientkeys,
          buttons = clientbuttons,
          screen = awful.screen.preferred,
          placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
    },
}

-- Signal function to execute when a new client appears
client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end

    -- Create the titlebar for new clients
    create_titlebar(c)
end)

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
    end
end)

-- Handle focus and unfocus events
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awesome.emit_signal("custom::notification", "Welcome", "AwesomeWM has started successfully!")
