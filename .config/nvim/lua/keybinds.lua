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

-- Wezterm Integration
local nav = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function navigate(key)
  return function()
    local win = vim.api.nvim_get_current_win()

    vim.cmd.wincmd(key)

    local pane = vim.env.WEZTERM_PANE

    if pane and win == vim.api.nvim_get_current_win() then
      local pane_dir = nav[key]

      vim.system({ "wezterm", "cli", "activate-pane-direction", pane_dir })
    end
  end
end

for key, dir in pairs(nav) do
  vim.keymap.set("n", "<C-" .. dir .. ">", navigate(key))
  vim.keymap.set("n", "<C-" .. key .. ">", navigate(key))
end
