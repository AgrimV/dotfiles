local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- General
config.font = wezterm.font("FiraMono Nerd Font Mono")
config.font_size = 11
config.default_prog = { "fish" }
config.window_close_confirmation = "NeverPrompt"

-- Window
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Colors
config.color_scheme = "matugen_theme"
config.force_reverse_video_cursor = true

-- Keybinds
config.keys = {
	{
		key = "'",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = '"',
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

return config
