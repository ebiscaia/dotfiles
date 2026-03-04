-- Main options
vim.opt.number = true -- Set numbers to be shown.
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Highlight cursor line underneath the cursor horizontal
vim.opt.cursorcolumn = true -- Highlight cursor line underneath the cursor vertically.

vim.opt.shiftwidth = 4 -- size of an indent
vim.opt.tabstop = 4 -- Tab to move by 4 characters
vim.opt.softtabstop = 4 -- Backspace to remove 4 white spaces at once
vim.opt.smartindent = true -- Enabled automatic indentation
vim.opt.expandtab = true -- Replace tabs with with spaces
vim.opt.scrolloff = 10 -- Show the number of lines before/after when scrolling up/down
vim.opt.ignorecase = true -- Ignore capital letters during search.
vim.opt.smartcase = true -- Override the ignorecase option if searching for capital letters.
vim.opt.guicursor = ""
vim.opt.showmode = true -- how the mode you are on the last line.
vim.opt.history = 500 -- Set the commands to save in history default number is 20.
vim.opt.splitbelow = true -- Define where splits should be shown
vim.opt.clipboard = "unnamedplus" -- Neovim can use the system clipboard
vim.opt.mouse = "r" -- Allows mouse usage
vim.opt.undofile = true -- enable persistent undo
vim.opt.signcolumn = "yes" -- replace a line number by a sign (linters/fixers)
vim.opt.termguicolors = true -- enable more colors
vim.opt.modifiable = true -- enable changes using neogit
vim.opt.swapfile = false -- disable swap file
vim.opt.winborder = "rounded"

vim.opt.scrolloff = 999 -- forces cursor to be in the middle of the screen
vim.opt.textwidth = 80

vim.g.mapleader = " " -- set space as the leader key

vim.hl.priorities.semantic_tokens = 50 -- allows treesitter to have preference (prior: 100) over lsp highlighting
