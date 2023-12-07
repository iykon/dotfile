local wk = require('which-key')
local mappings = {
    q = {":q<cr>", ""},
    w = {":w<cr>", "Save"},
    E = {":e ~/.config/nvim/init.lua<cr>", "Edit nvim config"},
    f = {":Telescope find_files<cr>", "find file"},
    g = {":Telescope live_grep<cr>", "live grep"},
    b = {":Telescope buffers<cr>", "show buffers"},
    t = {":Telescope help_tags<cr>", "show help tags"},
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
