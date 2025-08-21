local function map(mode, key, value, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, key, value, options)
end

map("n", "<Tab>", ":bnext<Enter>")
map("n", "<S-Tab>", ":bprev<Enter>")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-Up>", ":resize -2<Enter>")
map("n", "<C-Left>", ":vertical resize -2<Enter>")
map("n", "<C-Right>", ":vertical resize +2<Enter>")
map("n", "<C-Down>", ":resize +2<Enter>")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-o>", ":lua MiniFiles.open()<Enter>")
map("n", "<Leader>ff", ":Pick files<CR>")
map("n", "<Leader>fc", ":Pick grep_live<CR>")
map("n", "<C-`>", ":ToggleTerm<CR>")
