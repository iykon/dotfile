vim.cmd('filetype plugin indent on')
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.hidden = true
vim.g.mapleader = ' '
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
vim.o.pumheight = 10
--vim.o.fileencoding = 'utf-8'
vim.o.cmdheight = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.o.conceallevel = 0
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.clipboard = 'unnamedplus'
vim.o.hlsearch = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.mouse = "a"
vim.wo.wrap = false
vim.wo.number = true
vim.o.cursorline = true
vim.wo.signcolumn = "yes"

-- tabs
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true
