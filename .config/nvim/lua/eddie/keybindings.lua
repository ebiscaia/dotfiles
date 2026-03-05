-- Some keybindings
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":wq<CR>")
vim.keymap.set("n", "<leader>r", ":update<CR> :source<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
