-- Compatibility for older plugins that still call the deprecated API.
if vim.islist then
    vim.tbl_islist = vim.islist
end

local config_modules = {
    "options",
    "lualine-config",
    "nvimtree-config",
    "bufferline-config",
    "treesitter-config",
    "telescope-config",
    "whichkey-config",
    "keybindings",
    "cmp-config",
}

vim.api.nvim_create_user_command("ReloadConfig", function()
    for _, module in ipairs(config_modules) do
        package.loaded[module] = nil
    end

    dofile(vim.fn.stdpath("config") .. "/init.lua")
    vim.notify("Reloaded Neovim config")
end, {})

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
vim.o.background = "light"
vim.cmd([[
colorscheme gruvbox
]])
