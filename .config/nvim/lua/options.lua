local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.signcolumn = "yes"
opt.completeopt = "menu,menuone,noselect,preview"
opt.iskeyword:append({ "-" })
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.termguicolors = true
opt.winborder = "rounded"
opt.swapfile = false
opt.switchbuf = "usetab,newtab"
opt.ignorecase = true
opt.smartcase = true

vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})
