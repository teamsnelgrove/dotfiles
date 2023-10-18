local opt = vim.opt

vim.cmd.colorscheme "catppuccin"

opt.number = true
opt.nu = true
opt.relativenumber = true
opt.cmdheight = 1 -- Height of the command bar

-- Ignore compiled files
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append { "Cargo.lock", "Cargo.Bazel.lock" }

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.showmatch = true -- show matching brackets when text indicator is over them

opt.smartindent = true

opt.wrap = false

opt.swapfile = false -- living on the edge
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Search
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true  -- ... unless there is a capital letter in the query
opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.splitbelow = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.clipboard = 'unnamed'

-- :set winbar=%=%m\ %f

-- https://neovim.discourse.group/t/options-formatoptions-not-working-when-put-in-init-lua/3746
vim.cmd([[autocmd BufEnter * set formatoptions-=o]])
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = "options",
-- 	callback = function()
-- 		-- Disable automatic comments
-- 		vim.opt.formatoptions:remove({ "r", "o" })
-- 		-- Restore cursor position
-- 		local exclude = { diff = true, gitcommit = true, gitrebase = true }
-- 		local position_line = vim.api.nvim_buf_get_mark(0, [["]])[1]
-- 		if
-- 			not exclude[vim.bo.filetype]
-- 			and position_line >= 1
-- 			and position_line <= vim.api.nvim_buf_line_count(0)
-- 		then
-- 			vim.cmd.normal({
-- 				bang = true,
-- 				args = { [[g`"]] },
-- 			})
-- 		end
-- 	end,
-- })
-- opt.formatoptions = opt.formatoptions
--     - "a" -- Auto formatting is BAD.
--     - "t" -- Don't auto format my code. I got linters for that.
--     + "c" -- In general, I like it when comments respect textwidth
--     + "q" -- Allow formatting comments w/ gq
--     - "o" -- O and o, don't continue comments
--     + "r" -- But do continue when pressing enter.
--     + "n" -- Indent past the formatlistpat, not underneath it.
--     + "j" -- Auto-remove comments if possible.
--     - "2" -- I'm not in gradeschool anymore

-- opt.colorcolumn = "120"
-- vim.lsp.set_log_level("debug")
