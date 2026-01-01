local function map(mode, key, value, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, key, value, options)
end

map("n", "<Tab>", "gt")
map("n", "<S-Tab>", "gT")
map("n", "j", "gj")
map("n", "k", "gk")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Mini Keybinds
map("n", "<C-o>", ":lua MiniFiles.open()<Enter>")
map("n", "<Leader>ff", ":Pick files<CR>")
map("n", "<Leader>fc", ":Pick grep_live<CR>")

-- Treesitter Textobjects Keybinds
local move = require("nvim-treesitter-textobjects.move")
map({ "n", "x", "o" }, "]m", function()
  move.goto_next("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[m", function()
  move.goto_previous("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "]o", function()
  move.goto_next_start({ "@loop.outer", "@conditional.outer", "@loop.inner" }, "textobjects")
end)
map({ "n", "x", "o" }, "[o", function()
  move.goto_previous_start({ "@loop.outer", "@conditional.outer", "@loop.inner" }, "textobjects")
end)
map({ "n", "x", "o" }, "]z", function()
  move.goto_next_start("@fold", "folds")
end)
map({ "n", "x", "o" }, "[z", function()
  move.goto_previous_start("@fold", "folds")
end)

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
  map("n", "<C-" .. dir .. ">", navigate(key))
  map("n", "<C-" .. key .. ">", navigate(key))
end
