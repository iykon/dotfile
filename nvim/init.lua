require("plugins")
require("options")
require("lualine-config")
require("nvimtree-config")
require("bufferline-config")
require("treesitter-config")
require("keybindings")
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[
colorscheme gruvbox
NvimTreeOpen
]])