local treesitter = require("nvim-treesitter")
local ts_config = require("nvim-treesitter.config")

local ensure_installed = {
  "lua",
  "vim",
  "vimdoc",
  "help",
  "query",
  "markdown_inline",
  "markdown",
  "html",
  "yaml",
  "python",
  "comment",
}

local already_installed = ts_config.get_installed("parsers")
local parsers_to_install = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()
if #parsers_to_install > 0 then
  treesitter.install(parsers_to_install)
end

local function ts_start(bufnr, parser_name)
  -- highlights
  vim.treesitter.start(bufnr, parser_name)

  -- folds
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"
  vim.wo.foldlevel = 99

  -- indentation
  vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- Auto-install and start parsers for any buffer
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Enable Treesitter",
  callback = function(event)
    local bufnr = event.buf
    local filetype = event.match

    -- Skip if no filetype
    if filetype == "" then
      return
    end

    local parser_name = vim.treesitter.language.get_lang(filetype)
    if not parser_name then
      vim.notify(vim.inspect("No treesitter parser found for filetype: " .. filetype), vim.log.levels.WARN)
      return
    end

    -- Try to get existing parser
    if not vim.tbl_contains(ts_config.get_available(), parser_name) then
      return
    end

    -- Check if parser is already installed
    if not vim.tbl_contains(already_installed, parser_name) then
      -- If not installed, install parser asynchronously and start treesitter
      vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
      treesitter.install({ parser_name }):await(function()
        ts_start(bufnr, parser_name)
      end)
      return
    end

    ts_start(bufnr, parser_name)
  end,
})
