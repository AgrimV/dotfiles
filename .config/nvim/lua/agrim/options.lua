local opt = vim.opt
local cmd = vim.cmd

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = false
opt.expandtab = false
opt.textwidth = 79
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.backspace = 'indent,eol,start'
opt.clipboard = 'unnamedplus'
opt.showcmd = true
opt.cmdheight = 2
opt.ruler = false
opt.wildmenu = true
opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true
opt.smartcase = true
opt.ignorecase = true
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldmethod = 'indent'
opt.signcolumn = 'yes'
opt.completeopt = 'menu,menuone,noselect'
opt.background = 'dark'
opt.iskeyword:append({ '-' })
-- Look for alternative
cmd [[ colorscheme nightfox ]]
-- Gray Italic Comments
vim.api.nvim_set_hl(0, 'Comment', { italic=true, fg="#696969" })
