local function map(mode, key, value, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, value, options)
end

map("n", "<Tab>", ":tabnext<Enter>")
map("n", "<S-Tab>", ":tabprevious<Enter>")
map("n", "a", ":q")
map("n", "w", ":w<Enter>")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<Down>", "gj")
map("n", "<Up>", "gk")
map("n", "<C-o>", ":Fyler<Enter>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-Up>", ":resize -2<Enter>")
map("n", "<C-Left>", ":vertical resize -2<Enter>")
map("n", "<C-Right>", ":vertical resize +2<Enter>")
map("n", "<C-Down>", ":resize +2<Enter>")
map("n", "Fp", ":echo expand('%:p')<Enter>")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "p", '"_dP')
