local function matugen_reload()
  package.loaded["matugen"] = nil
  package.loaded["cyanide"] = nil
  package.loaded["statusline"] = nil

  local stat = vim.loop.fs_stat(vim.fn.stdpath("config") .. "/lua/matugen.lua")
  if stat and stat.type == "file" then
    local MatugenPalette = require("matugen")
    require("cyanide").setup({
      Background = MatugenPalette.background,
    })
    require("statusline")
  end
end

vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = matugen_reload,
})

local M = {}

M.setup = function()
  matugen_reload()
end

return M
