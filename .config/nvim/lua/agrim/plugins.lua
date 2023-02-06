vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile profile=true
  augroup end
]])

-- Plugin installation
local use = require("packer").use
require("packer").startup(function()
  -- Package Manager
  use 'wbthomason/packer.nvim'

  -- General
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
    },
  }
  use 'hrsh7th/nvim-cmp'
  use({
	"L3MON4D3/LuaSnip",
	-- follow latest release. currently 1.2.1
	tag = "v1.*",
  })
  use 'hrsh7th/cmp-nvim-lsp'
  use 'terrortylor/nvim-comment'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'windwp/nvim-autopairs'
  use {
    'kylechui/nvim-surround',
    tag = "*",
	-- Use for stability; omit to use `main` branch for the latest features
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }

  -- Colorschemes
  use 'joshdick/onedark.vim'
  use 'arzg/vim-colors-xcode'
  use 'yuqio/vim-darkspace'
  use 'NLKNguyen/papercolor-theme'
  use 'tomasiser/vim-code-dark'
  use 'danilo-augusto/vim-afterglow'
  use 'liuchengxu/space-vim-dark'
  use 'crusoexia/vim-monokai'
  use 'flazz/vim-colorschemes'
  use 'morhetz/gruvbox'
  use 'catppuccin/vim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use 'JoosepAlviste/palenightfall.nvim'
  use {
    'uloco/bluloco.nvim',
    requires = { 'rktjmp/lush.nvim' }
  }

end)
