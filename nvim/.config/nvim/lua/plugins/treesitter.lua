return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = { "python", "rust", "javascript", "typescript", "lua" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
                disable = { "python" },
            },

            -- Treesitter textobjects
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- Functions
                        ["af"] = { query = "@function.outer", desc = "Select inner part of a function region" },
                        ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
                        -- Classes
                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        -- Arguments
                        ["ia"] = { query = "@parameter.inner", desc = "Select argument" },
                        ["aa"] = { query = "@parameter.outer", desc = "Select argument and trailing comma" },
                        ["ip"] = "@call.inner"
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                },
            },
        }
    end
}
