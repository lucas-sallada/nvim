-- NvimTree keymaps
vim.keymap.set('n', '[e', ':NvimTreeToggle<CR>', { desc = 'Open Tree', silent = true })
vim.keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', { desc = 'Find File in Tree', silent = true })
