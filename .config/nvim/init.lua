---- Ivy's Neovim config ----

--- Settings
vim.g.mapleader = " " -- set before everything else gets init'd

-- numbers
vim.o.number = true
vim.o.relativenumber = true

vim.opt.cursorline = true      -- Highlight current line
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

vim.opt.updatetime = 250       -- Faster completion & CursorHold events
vim.opt.timeoutlen = 500       -- Faster mapped sequence completion

--- Keymaps
local map = vim.keymap.set

map('n', '<leader>o', '<CMD>update<CR> <CMD>source<CR>') -- reload file
map('n', '<leader>r', '<CMD>write<CR>') -- save | will i add autosave? maybe

vim.pack.add({
	{src = "https://github.com/catppuccin/nvim", name = "catppuccin"}, -- Theme
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/echasnovski/mini.nvim", version = "main" }
})

require('mini.icons').setup()

require("oil").setup({
	default_file_explorer = true,
})
map('n', '<leader>f', "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

vim.cmd.colorscheme "catppuccin-latte"
