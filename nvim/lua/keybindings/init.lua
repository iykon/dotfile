vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})

map('i', 'jk', '<ESC>', {noremap = true, silent = false})
map('n', '<space>e', ':NvimTreeToggle<CR>', {noremap = true, silent = false})

map('n', '<space>h', ':nohlsearch<CR>', {noremap = true, silent = false})

--move cursor
map('i', '<C-b>', '<Left>', {noremap = true, silent = false})
map('i', '<C-f>', '<Right>', {noremap = true, silent = false})
map('i', '<C-d>', '<Delete>', {noremap = true, silent = false})

--nvimtree
map('n', '+', ':NvimTreeResize +1<CR>', {noremap = true, silent = false})
map('n', '_', ':NvimTreeResize -1<CR>', {noremap = true, silent = false})
