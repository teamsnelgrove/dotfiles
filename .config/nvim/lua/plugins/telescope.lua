return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        -- or                              , branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
            },

        },
        config = function()
            require("telescope").setup {
                defaults = {
                    -- wrap_results = true,
                    file_ignore_patterns = { ".git/" },
                },
                pickers = {
                    find_files = { hidden = true, },
                    git_files = { show_untracked = true },
                    live_grep = { additional_args = { "--hidden" } },
                    buffers = {
                        sort_lastused = true,
                        sort_mru = true,
                    },
                },
                extensions = {
                    file_browser = {
                        -- disables netrw and use telescope-file-browser in its place
                        -- hijack_netrw = true,
                        hidden = { file_browser = true, folder_browser = false },
                    },
                },
            }

            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension "file_browser"

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
            vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>*', builtin.grep_string, {})
            vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, {})

            vim.keymap.set(
                "n",
                "<space>fh",
                ":Telescope file_browser<CR>",
                { noremap = true }
            )

            vim.keymap.set(
                "n",
                "<space>fb",
                ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
                { noremap = true }
            )

            local pickers = require "telescope.pickers"
            local finders = require "telescope.finders"
            local conf = require("telescope.config").values
            local actions = require "telescope.actions"
            local action_state = require "telescope.actions.state"

            local find_in_directory = function(opts)
                opts = opts or {}
                opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
                pickers.new(opts, {
                    prompt_title = "colors",
                    finder = finders.new_oneshot_job({ "fd", "-t", "d" }, opts),
                    sorter = conf.file_sorter(opts),
                    attach_mappings = function(prompt_bufnr, _)
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            builtin.live_grep({
                                cwd = selection.value,
                                additional_args = { "--hidden" },
                            })
                        end)
                        return true
                    end,
                }):find()
            end
            vim.keymap.set(
                "n",
                "<space>fd",
                find_in_directory,
                { noremap = true }
            )
        end
    }
}
