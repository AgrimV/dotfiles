require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "ayu_dark",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "NvimTree" },
      winbar = { "NvimTree" },
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    } },
    lualine_b = { { "branch", icon = "" } },
    lualine_c = { "diagnostics" },
    lualine_x = {},
    lualine_y = { "diff" },
    lualine_z = { "location" },
  },
  inactive_sections = {},
  tabline = {
    lualine_a = {
      {
        "buffers",
        mode = 0,
        max_length = vim.o.columns,
        symbols = {
          modified = " ",
          alternate_file = "",
        },
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
