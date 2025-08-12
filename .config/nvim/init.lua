---- Ivy's Neovim config ----

--- Settings
vim.g.mapleader = " " -- set before everything else gets init'd

-- numbers
vim.o.number = true
vim.o.relativenumber = true

vim.opt.cursorline = true      -- Highlight current line
vim.cmd.colorcolumn = 79
vim.opt.signcolumn = "yes"     -- Always show sign column
vim.opt.wrap = false           -- Disable line wrap
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8      -- Keep 8 columns visible left/right of cursor
vim.opt.termguicolors = true   -- Enable 24-bit RGB colors

-- Indentation
vim.opt.tabstop = 4            -- Number of spaces tabs count for
vim.opt.shiftwidth = 4         -- Number of spaces for each indent
vim.opt.expandtab = false       -- Don't convert tabs to spaces
vim.opt.smartindent = true     -- Smart auto-indenting

-- Search
vim.opt.ignorecase = true      -- Ignore case in search
vim.opt.smartcase = true       -- Override ignorecase if search has capitals
vim.opt.incsearch = true       -- Show matches while typing
vim.opt.hlsearch = true        -- Highlight search matches

vim.opt.undofile = true        -- Persistent undo
vim.opt.swapfile = false       -- Disable swap files
vim.opt.backup = false         -- Disable backup files

vim.opt.clipboard = "unnamedplus" -- Use system clipboard

--- Keymaps
local map = vim.keymap.set

--- Plugins
vim.pack.add({
	{src = "https://github.com/catppuccin/nvim", name = "catppuccin"}, -- Theme
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/echasnovski/mini.nvim", version = "main" },
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/j-hui/fidget.nvim", -- notifications
	"https://github.com/kdheepak/lazygit.nvim"
})

vim.cmd.colorscheme "catppuccin"

-- mini
require('mini.icons').setup()
require('mini.starter').setup({
	header = "ivy.nvim",
	footer = ""
})
require('mini.statusline').setup()
require('mini.git').setup()
require('mini.diff').setup({
	view = {
		style = "sign"
	}
})

-- moar git
map('n', '<leader>G', '<CMD>LazyGit<CR>')

-- notifications
require('fidget').setup({
	notification = {
		override_vim_notify = true
	}
})

require("nvim-autopairs").setup()

-- files
require("oil").setup({
	default_file_explorer = true,
})

map('n', '<leader>f', "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
