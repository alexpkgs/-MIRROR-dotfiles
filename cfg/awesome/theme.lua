local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "Cartograph CF 9"

local backgroundColor = '#282424'
local foregroundColor = '#ffffff'
local highlightColor = '#ffffff'
local barbg = '#282424'
local barfg = '#ffffff'

theme.bg_normal     = barbg
theme.bg_focus      = barfg
theme.bg_urgent     = "#444444"
theme.bg_minimize   = "#ff5555"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = foregroundColor
theme.fg_focus      = foregroundColor
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#282a36"

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(0)
theme.border_normal = highlightColor
theme.border_focus  = highlightColor
theme.border_marked = "#91231c"

-- Titlebar colors
theme.titlebar_bg_normal = "#282424"  -- Set titlebar background color
theme.titlebar_bg_focus  = "#282424"  -- Set titlebar background color when focused
theme.titlebar_fg_normal = "#282424"   -- Set titlebar text color
theme.titlebar_fg_focus  = "#282424"   -- Set titlebar text color when focused

local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.menu_submenu_icon = themes_path.."~/.config/awesome/icons/awesome.png"
theme.menu_height = dpi(30)
theme.menu_width  = dpi(150)

-- Wallpaper
theme.wallpaper = "~/.config/awesome/walls/wals.png"

theme.icon_theme = nil

return theme
