local wezterm = require("wezterm")

local config = {
    font = wezterm.font_with_fallback({
        { family = "Cartograph CF", weight = "Regular", stretch = "Normal", style = "Normal" },
    }),
    font_size = 10,
    color_scheme = "custom_scheme",
    enable_tab_bar = false,
    window_padding = {
        left = 40,
        right = 40,
        top = 40,
        bottom = 40,
    }
}

config.color_schemes = {
    ["custom_scheme"] = {
        foreground = "#685c56",
        background = "#eaecf2",
        cursor_bg = "#685c56",
        cursor_border = "#685c56",  -- Use the same as cursor_bg
        cursor_fg = "#F0EDEC",
        selection_bg = "#a8623e",  -- Use a color from your theme
        selection_fg = "#F0EDEC",
        ansi = {
            "#F0EDEC",  -- black
            "#a8334c",  -- red
            "#597a37",  -- green
            "#a8623e",  -- yellow
            "#286486",  -- blue
            "#88507D",  -- magenta
            "#3B8992",  -- cyan
            "#ddd3d2",  -- white
        },
        brights = {
            "#e9e4e2",  -- bright black
            "#ff5555",  -- bright red
            "#35a69c",  -- bright green
            "#a8623e",  -- bright yellow
            "#cbd9e3",  -- bright blue
            "#8850b4",  -- bright magenta
            "#2a646b",  -- bright cyan
            "#948985",  -- bright white
        },
    },
}

return config

