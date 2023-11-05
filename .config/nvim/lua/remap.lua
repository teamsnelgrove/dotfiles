vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
-- don't copy the value for delete
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Copy current file name
-- TODO: get this to system clipboard
-- vim.keymap.set("n", "<leader>fy", [[<cmd>let @" = expand("%")<cr>]])

vim.keymap.set("n", "<leader>fy", function()
    -- relative path with filename
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    print(path)

    -- absolute path with filename
    -- local cwd = vim.fn.expand("%:p")
    -- relative directory path
    -- local cwd = vim.fn.expand("%:h")
    -- absolute directory path
    -- local cwd = vim.fn.expand("%:p:h")
end)

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>=", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>se", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- buffer remaps
vim.keymap.set("n", "<leader><TAB>", "<cmd>:b#<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>:bprevious<CR>")
vim.keymap.set("n", "<leader>bn", "<cmd>:bnext<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>:bdelete<CR>")

-- file operations
vim.keymap.set("n", "<leader>fs", "<cmd>:w<CR>")

