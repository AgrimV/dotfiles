vim.keymap.set("t", "<esc>", "<c-\\><c-n>")

local terminal_state = {
  buffer = -1,
  window = -1,
}

local window_config = function()
  return {
    relative = "editor",
    width = vim.o.columns,
    height = math.floor(vim.o.lines * 0.34),
    col = 0,
    row = math.floor(vim.o.lines * 0.66),
    style = "minimal",
  }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(terminal_state.window) then
    if not vim.api.nvim_buf_is_valid(terminal_state.buffer) then
      terminal_state.buffer = vim.api.nvim_create_buf(false, true)
    end

    terminal_state.window = vim.api.nvim_open_win(terminal_state.buffer, true, window_config())

    if vim.bo[terminal_state.buffer].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(terminal_state.window)
  end
end

vim.api.nvim_create_user_command("ToggleTerm", toggle_terminal, {})
