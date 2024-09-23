local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "Cartograph 10"

backgroundColor = '#F0EDEC'
foregroundColor = '#685c56'
highlightColor = '#1f1104'

theme.bg_normal     = backgroundColor
theme.bg_focus      = foregroundColor
theme.bg_urgent     = "#444444"
theme.bg_minimize   = "#ff5555"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = foregroundColor
theme.fg_focus      = backgroundColor
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#282a36"

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(3)
theme.border_normal = backgroundColor
theme.border_focus  = highlightColor
theme.border_marked = "#91231c"


local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)


theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Wallpaper
theme.wallpaper = "~/walls/wall.png"

theme.icon_theme = nil

return theme