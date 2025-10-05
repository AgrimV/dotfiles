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
    -- General
    {
      "nvim-lualine/lualine.nvim",
    },
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },
    {
      "karb94/neoscroll.nvim",
      opts = {},
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
          css = { "prettier" },
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
        require("mini.icons").setup()
        require("mini.surround").setup({})
        require("mini.pick").setup({
          mappings = {
            choose_in_tabpage = "<CR>",
            choose = "<C-t>",
          },
        })
        require("mini.indentscope").setup({
          draw = {
            delay = 1,
            animation = require("mini.indentscope").gen_animation.none(),
          },
        })
        require("mini.hipatterns").setup({
          highlighters = {
            hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
          },
        })
        require("mini.files").setup({})

        local map_split = function(buf_id, key, close_after)
          local open_file = function()
            local fs_entry = MiniFiles.get_fs_entry()
            if fs_entry.fs_type == "directory" then
              MiniFiles.go_in()
              return
            end

            local cur_target = MiniFiles.get_explorer_state().target_window
            local new_target = vim.api.nvim_win_call(cur_target, function()
              vim.cmd("tab split")
              return vim.api.nvim_get_current_win()
            end)

            MiniFiles.set_target_window(new_target)
            MiniFiles.go_in({
              close_on_file = close_after,
            })
          end

          vim.keymap.set("n", key, open_file, { buffer = buf_id })
        end

        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniFilesBufferCreate",
          callback = function(args)
            local buf_id = args.data.buf_id
            map_split(buf_id, "l", true)
            map_split(buf_id, "L", false)
          end,
        })
      end,
    },
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },

      version = "1.*",

      opts = {
        keymap = { preset = "super-tab" },
        completion = { documentation = { auto_show = true } },
        signature = { enabled = true },
      },
      opts_extend = { "sources.default" },
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      opts = {},
    },

    -- Colorschemes
    {
      "AgrimV/cyanide.nvim",
      config = function()
        -- vim.cmd("colorscheme cyanide")

        local stat = vim.loop.fs_stat(vim.fn.stdpath("config") .. "/lua/matugen.lua")
        if stat and stat.type == "file" then
          local MatugenPalette = require("matugen")
          require("cyanide").setup({
            Background = MatugenPalette.background,
          })
        end
      end,
    },
  },
  checker = { enabled = true },
})
