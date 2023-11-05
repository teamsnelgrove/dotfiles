return {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
        require('lualine').setup {
            options = {
                theme = "catppuccin",
                section_separators = '',
                component_separators = '',
                globalstatus = true,
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = {
                "aerial",
                "fugitive",
                "lazy",
                "man",
                "nvim-dap-ui",
                "trouble",
                "mason",
                "quickfix",
            }
        }
    end
}
