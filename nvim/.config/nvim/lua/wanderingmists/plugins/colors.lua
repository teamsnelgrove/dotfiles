require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
        cmp = true,
        treesitter = true,
    }
})
vim.cmd.colorscheme "catppuccin"
