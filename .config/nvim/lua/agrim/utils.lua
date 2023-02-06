require("nvim-autopairs").setup {}
require("nvim-surround").setup {}
require("todo-comments").setup {}

-- Indent Line
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
