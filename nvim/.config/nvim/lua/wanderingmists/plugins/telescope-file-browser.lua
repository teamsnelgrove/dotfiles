require("telescope").setup {
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      hidden = { file_browser = true, folder_browser = false },
    },
  },
}
require("telescope").load_extension "file_browser"
vim.api.nvim_set_keymap(
  "n",
  "<space>fh",
  ":Telescope file_browser<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)
