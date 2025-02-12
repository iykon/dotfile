local wk = require('which-key')

wk.add({
    { "<leader>q", ":q<cr>", desc = ""},
    { "<leader>w", ":w<cr>", desc = "Save"},
    { "<leader>E", ":e ~/.config/dotfile/nvim/init.lua<cr>", desc = "Edit nvim config"},
    { "<leader>f", ":Telescope find_files<cr>", desc = "find file"},
    { "<leader>g", ":Telescope live_grep<cr>", desc = "live grep"},
    { "<leader>b", ":Telescope buffers<cr>", desc = "show buffers"},
    { "<leader>t", ":Telescope help_tags<cr>", desc = "show help tags"},
})
