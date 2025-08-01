require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<Leader>ss", -- set to `false` to disable one of the mappings
            node_incremental = "<Leader>si",
            scope_incremental = "<Leader>sc",
            node_decremental = "<Leader>sd",
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",

                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",

                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",

                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",

                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                -- You can also use captures from other query groups like `locals.scm`
                -- ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },

            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
                ["@parameter.outer"] = "v",
                ["@function.outer"] = "v",
                ["@class.outer"] = "V",
                -- 'v' -- charwise
                -- 'V' -- linewise
                -- '<c-v>' -- blockwise
            },

            include_surrounding_whitespace = true,
        },
    },
})
