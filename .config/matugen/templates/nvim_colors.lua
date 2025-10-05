local Palette = {
	Background = "{{colors.background.default.hex}}",
}

local highlight_override_map = {
	SignColumn = { bg = Palette.Background },
	Normal = { bg = Palette.Background },
	TabLine = { bg = Palette.Background },
}

for highlight_group, highlight_value in pairs(highlight_override_map) do
	vim.api.nvim_set_hl(0, highlight_group, highlight_value)
end
