local function map(mode, key, value, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, key, value, options)
end

map("n", "<Tab>", "gt")
map("n", "<S-Tab>", "gT")
map("n", "j", "gj")
map("n", "k", "gk")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-o>", ":lua MiniFiles.open()<Enter>")
map("n", "<Leader>ff", ":Pick files<CR>")
map("n", "<Leader>fc", ":Pick grep_live<CR>")
map("n", "<C-`>", ":ToggleTerm<CR>")
