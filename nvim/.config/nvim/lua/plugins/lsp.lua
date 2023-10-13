return {
    -- "nvim-treesitter/nvim-treesitter-context",
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-buffer' },
            { "folke/neodev.nvim" },
            { 'L3MON4D3/LuaSnip' }, -- Required
        },
        config = function()
            local lsp = require("lsp-zero")

            lsp.preset("recommended")

            lsp.ensure_installed({
                'rust_analyzer',
                'pylsp',
            })

            -- Fix Undefined global 'vim'
            lsp.nvim_workspace()


            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            })

            cmp_mappings['<Tab>'] = nil
            cmp_mappings['<S-Tab>'] = nil

            cmp.setup({
                sources = {
                    { name = "nvim_lua" },
                    { name = "nvim_lsp" },
                    { name = 'nvim_lsp_signature_help' },
                    {
                        name = "buffer",
                        keyword_length = 5
                    },
                }
            })
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })

            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            lsp.setup_nvim_cmp({
                mapping = cmp_mappings
            })

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })

            lsp.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                -- function is called incorrectly according to linter. I probably copied this from someone else's config
                -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)

            vim.diagnostic.config({
                virtual_text = true
            })

            -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
            require("neodev").setup({})

            local root_pattern = require('lspconfig.util').root_pattern

            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "redis", "ARGV", "KEYS", "cjson", "vim" },
                        }
                    }
                }
            }

            -- vim.list_extend(vim.lsp.override, { "pyright", "pylsp" })
            require('lspconfig').pylsp.setup {
                root_dir = root_pattern('pyproject.toml'),
                settings = {
                    pylsp = {
                        plugins = {
                            black = { enabled = false },
                            ruff = { enabled = false },
                            pycodestyle = { enabled = false },
                            flake8 = { enabled = false },
                            pyflakes = { enabled = false },
                            mccabe = { enabled = false },
                            isort = { enabled = false },
                            mypy = { enabled = false },
                        }
                    }
                },
                flags = {
                    debounce_text_changes = 200,
                },
            }

            require("lspconfig").ruff_lsp.setup({
                -- organize imports disabled, since we are already using `isort` for that
                -- alternative, this can be enabled to make `organize imports`
                -- available as code action
                settings = {
                    organizeImports = false,
                },
                -- disable ruff as hover provider to avoid conflicts with pyright
                -- on_attach = function(client) client.server_capabilities.hoverProvider = false end,
            })

            lsp.setup()
        end
    },
}
