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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
  -- General
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim'},
  {'nvim-treesitter/nvim-treesitter'},
  {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    },
  },
  {'hrsh7th/nvim-cmp'},
  {
	"L3MON4D3/LuaSnip",
	-- follow latest release. currently 2.4.0
	version = "v2.*",
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'terrortylor/nvim-comment'},
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  {'windwp/nvim-autopairs'},
  {
    'kylechui/nvim-surround',
	event = "VeryLazy",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { 'nvim-telescope/telescope-fzf-native.nvim',
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'   },
  {
      'nvim-telescope/telescope.nvim',
      version = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },

  -- Colorschemes
  {'joshdick/onedark.vim'},
  {'arzg/vim-colors-xcode'},
  {'yuqio/vim-darkspace'},
  {'NLKNguyen/papercolor-theme'},
  {'tomasiser/vim-code-dark'},
  {'danilo-augusto/vim-afterglow'},
  {'liuchengxu/space-vim-dark'},
  {'crusoexia/vim-monokai'},
  {'flazz/vim-colorschemes'},
  {'morhetz/gruvbox'},
  {'catppuccin/vim'},
  {'EdenEast/nightfox.nvim'},
  {'folke/tokyonight.nvim'},
  {'JoosepAlviste/palenightfall.nvim'},
  {
    'uloco/bluloco.nvim',
    dependencies = { 'rktjmp/lush.nvim' }
  },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --install = { colorscheme = { "tokyonight-night" } }, -- maybe look for better
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Look for alternative
vim.cmd("colorscheme tokyonight-night")
