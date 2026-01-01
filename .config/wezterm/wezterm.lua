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
config.disable_default_key_bindings = true
config.keys = {
	-- Defaults
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "[",
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = "]",
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},
	{
		key = "f",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Search({ CaseSensitiveString = "" }),
	},
	{
		key = "c",
		mods = "ALT",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},

	-- Splits
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Resize
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{ key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
}

-- NeoVim Integration
local pane_nav = {
	Left = { "h", "LeftArrow" },
	Down = { "j", "DownArrow" },
	Up = { "k", "UpArrow" },
	Right = { "l", "RightArrow" },
}

local is_nvim = function(pane)
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

---@param dir "Right" | "Left" | "Up" | "Down"
local activate_pane = function(dir)
	return wezterm.action_callback(function(window, pane)
		if is_nvim(pane) then
			window:perform_action(wezterm.action.SendKey({ key = pane_nav[dir][1], mods = "CTRL" }), pane)
		else
			window:perform_action(wezterm.action.ActivatePaneDirection(dir), pane)
		end
	end)
end

for dir, keys in pairs(pane_nav) do
	for _, key in ipairs(keys) do
		wezterm.log_info(key)
		wezterm.log_info(dir)
		table.insert(config.keys, { key = key, mods = "CTRL", action = activate_pane(dir) })
	end
end

return config
