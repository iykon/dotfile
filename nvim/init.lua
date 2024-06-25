require("plugins")
require("options")
require("lualine-config")
require("nvimtree-config")
require("bufferline-config")
require("treesitter-config")
require("telescope-config")
require("whichkey-config")
require("keybindings")
require("cmp-config")
-- require("rusttools-config")
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[
colorscheme gruvbox
]])
