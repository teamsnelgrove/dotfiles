return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            require("nvim-dap-virtual-text").setup()
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            vim.keymap.set("n", "<leader>dt", dapui.toggle)
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap = require('dap')
            local dap_py = require('dap-python')

            dap_py.setup()
            dap_py.test_runner = 'pytest'
            -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
            table.insert(dap.configurations.python, {
                type = 'python',
                request = 'launch',
                name = 'My custom launch configuration',
                program = '${file}',
            })
            table.insert(dap.configurations.python, {
                type = 'server',
                request = 'attach',
                name = 'Debugpy',
                justMyCode = false,
                connect = {
                    host = '127.0.0.1',
                    port = 8001,
                }
            })
            vim.keymap.set("n", "<leader>dtm", dap_py.test_method)
            vim.keymap.set("n", "<leader>dtc", dap_py.test_class)
        end
    }
}
