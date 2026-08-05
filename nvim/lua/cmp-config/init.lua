vim.g.completeopt="menu,menuone,noselect,noinsert"
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Set up lspconfig.
local capabilities = require'cmp_nvim_lsp'.default_capabilities()
local lspconfig = require('lspconfig')

local lsp_attach = function(client, buf)
    vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig.html.setup {
    on_attach = lsp_attach,
    capabilities = capabilities
}


-- require'lspconfig'.rust_analyzer.setup {
    -- capabilities = capabilities
-- }

lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        lsp_attach(client, bufnr)
    end,
    capabilities = capabilities,
}

lspconfig.lua_ls.setup {
    on_attach = lsp_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
                preloadFileSize = 10000,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

-- local rust_capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('rust-tools').setup {
    capabilities = capabilities,
}

vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>s', vim.diagnostic.setloclist)

-- Clear the old auto-popup diagnostic autocmd when reloading this config.
vim.api.nvim_create_augroup("float_diagnostic", { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = function(desc)
      return { buffer = ev.buf, desc = desc }
    end

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('Go to declaration'))
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts('Go to definition'))
    vim.keymap.set('n', '<space>ld', require('telescope.builtin').lsp_definitions, opts('Go to definition'))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('Hover documentation'))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts('Go to implementation'))
    vim.keymap.set('n', '<space>li', vim.lsp.buf.implementation, opts('Go to implementation'))
    vim.keymap.set('n', '<space>lf', function()
      require('telescope.builtin').lsp_document_symbols({
        bufnr = ev.buf,
        symbols = { 'function', 'method', 'constructor' },
        show_line = true,
      })
    end, opts('List functions in file'))
    vim.keymap.set('n', '<space>lu', function()
      require('telescope.builtin').lsp_references({
        bufnr = ev.buf,
        include_declaration = false,
        show_line = true,
        jump_type = 'never',
      })
    end, opts('Show symbol usages'))
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts('Signature help'))
    vim.keymap.set('n', '<space>ka', vim.lsp.buf.add_workspace_folder, opts('Add workspace folder'))
    vim.keymap.set('n', '<space>kr', vim.lsp.buf.remove_workspace_folder, opts('Remove workspace folder'))
    vim.keymap.set('n', '<space>kl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts('List workspace folders'))
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts('Go to type definition'))
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts('Rename symbol'))
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts('Code action'))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts('List references'))
    vim.keymap.set('n', '<space>n', function()
      vim.lsp.buf.format { async = true }
    end, opts('Format buffer'))
  end,
})

vim.api.nvim_create_user_command('LspRestart', function(info)
  local servers = info.fargs

  if #servers == 0 then
    local seen = {}
    servers = vim
      .iter(vim.lsp.get_clients())
      :map(function(client)
        return client.name
      end)
      :filter(function(name)
        if seen[name] or vim.lsp.config[name] == nil then
          return false
        end

        seen[name] = true
        return true
      end)
      :totable()
  end

  for _, name in ipairs(servers) do
    if vim.lsp.config[name] == nil then
      vim.notify(("Invalid server name '%s'"):format(name), vim.log.levels.WARN)
    else
      vim.lsp.enable(name, false)
      for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
        client:stop(true)
      end
    end
  end

  local timer = assert(vim.uv.new_timer())
  timer:start(500, 0, function()
    for _, name in ipairs(servers) do
      if vim.lsp.config[name] ~= nil then
        vim.schedule(function()
          vim.lsp.enable(name)
        end)
      end
    end
    timer:close()
  end)
end, {
  desc = 'Restart configured LSP servers, ignoring non-lspconfig clients like Copilot',
  nargs = '*',
})
