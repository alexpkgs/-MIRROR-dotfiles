local wezterm = require("wezterm")

local config = {
    font = wezterm.font_with_fallback({
        { family = "Cartograph CF", weight },
    }),
    font_size = 10,
    color_scheme = "custom_scheme",
    enable_tab_bar = false,
    window_padding = {
        left = 40,
        right = 40,
        top = 40,
        bottom = 40,
    },
}

config.color_schemes = {
    ["custom_scheme"] = {
        foreground = "#F0EDEC",  -- updated fg
        background = "#282424",   -- updated bg
        cursor_bg = "#685c56",
        cursor_border = "#685c56",
        cursor_fg = "#F0EDEC",
        selection_bg = "#3B8992",  -- bright cyan
        selection_fg = "#685c56",   -- updated fg
        ansi = {
            "#F0EDEC",  -- black
            "#cd6059",  -- red
            "#597a37",  -- green
            "#a8623e",  -- yellow
            "#286486",  -- blue
            "#88507D",  -- magenta
            "#3B8992",  -- cyan
            "#ddd3d2",  -- white
        },
        brights = {
            "#d2c6c5",  -- bright white
            "#ff5555",  -- bright red
            "#35a69c",  -- bright green
            "#a8623e",  -- bright yellow
            "#cbd9e3",  -- bright blue
            "#8850b4",  -- bright magenta
            "#948985",  -- bright black
            "#2a646b",  -- bright cyan
        },
    },
}

return config