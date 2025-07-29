vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

-- function to define custom behavior for nvim-tree open
local function my_on_attach(bufnr)
  local nvim_tree_api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  nvim_tree_api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "<CR>", nvim_tree_api.node.open.tab, opts "Open: New Tab")
  vim.keymap.set("n", "<C-t>", nvim_tree_api.node.open.edit, opts "Open")
end

require("nvim-tree").setup {
  on_attach = my_on_attach,
}
