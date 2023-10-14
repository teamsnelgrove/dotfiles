return {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
        require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
        -- to show diff splits and open commits in browser
        "nvim-telescope/telescope.nvim",
        -- to open commits in browser with fugitive
        "tpope/vim-fugitive",
    },
}
