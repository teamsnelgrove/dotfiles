require("telescope").setup {
  defaults = {
    -- wrap_results = true,
    file_ignore_patterns = { ".git/" }
  },
  pickers = {
    find_files = { hidden = true, },
    git_files = { show_untracked = true }
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

-- vim.keymap.set('n', '<leader>ps', function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)

vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>*', builtin.grep_string, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, {})

