-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup {
    spec = {
        -- Colorschemes
        {
            "ofirgall/ofirkai.nvim",
            config = function()
                vim.cmd("colorscheme ofirkai")
            end,
        },

        -- General
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons", lazy = true,
            },
        },
        {
            "AgrimV/fyler.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            branch = "tabedit-files",
            opts = {
                icon_provider = "nvim-web-devicons",
                mappings = {
                    explorer = {
                        ["<CR>"] = "NewTab",
                        ["<C-t>"] = "Select",
                    },
                },
                views = {
                    explorer = {
                        win = {
                            kind = "split_left_most",
                            split_left_most = {
                                width = 0.33,
                            },
                        },
                    },
                },
            },
        },

        -- Coding
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "master", lazy = false, build = ":TSUpdate",
            config = function () 
                require("treesitter")
            end
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
        },
        {
            "neovim/nvim-lspconfig",
            config = function()
                require("lsp")
            end
        },
    },
    checker = { enabled = true },
}
