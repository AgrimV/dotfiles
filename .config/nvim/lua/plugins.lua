-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Colorschemes
    {
      "ofirgall/ofirkai.nvim",
      config = function()
        vim.cmd("colorscheme ofirkai")
      end,
    },

    -- General
    {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
      },
    },
    {
      "brenoprata10/nvim-highlight-colors",
      opts = {
        render = "virtual",
        virtual_symbol = "",
        exclude_filetypes = {},
        exclude_buftypes = {},
      },
    },
    {
      "AgrimV/fyler.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        icon_provider = "nvim-web-devicons",
        mappings = {
          explorer = {
            ["<C-t>"] = "Select",
            ["<CR>"] = "SelectTab",
          },
        },
      },
    },

    -- Coding
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      lazy = false,
      build = ":TSUpdate",
      config = function()
        require("treesitter")
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("lsp")
      end,
    },
    {
      "mason-org/mason.nvim",
      opts = {},
    },
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      },
    },
    {
      "echasnovski/mini.nvim",
      version = "*",
      config = function()
        require("mini.pick").setup({
          mappings = {
            choose = "<C-t>",
            choose_in_tabpage = "<CR>",
          },
        })
        require("mini.indentscope").setup({
          draw = {
            delay = 1,
            animation = require("mini.indentscope").gen_animation.none(),
          },
        })
        require("mini.surround").setup()
      end,
    },
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },

      version = "1.*",

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = "super-tab" },
        completion = { documentation = { auto_show = true } },
      },
      opts_extend = { "sources.default" },
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      opts = {},
    },
  },
  checker = { enabled = true },
})
