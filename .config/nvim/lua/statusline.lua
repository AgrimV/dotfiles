require("lualine").setup({
  options = {
    theme = "ayu_dark",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    always_divide_middle = false,
  },
  sections = {
    lualine_a = { {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    } },
    lualine_b = { "diagnostics" },
    lualine_c = { "location" },
    lualine_x = { "%S" },
    lualine_y = { "diff" },
    lualine_z = { { "branch", icon = "" } },
  },
  inactive_sections = {},
  tabline = {
    lualine_a = {
      {
        "tabs",
        mode = 2,
        icons_enabled = false,
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
