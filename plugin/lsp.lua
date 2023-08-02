local nvim_lsp = require('lspconfig.lspconfig')
local rt = require('rust-tools')

vim.api.nvim_create_augroup('AutoFormatting', {})

-- Elm format
vim.api.nvim_create_autocmd(
    "BufWritePre",
    { pattern = "*.elm",
      group = "AutoFormatting",
      callback = function()
        vim.lsp.buf.format({async = true})
      end
    }
)
-- Go format
vim.api.nvim_create_autocmd(
    "BufWritePre",
    { pattern = "*.go",
      group = 'AutoFormatting',
      callback = function()
        vim.lsp.buf.format({async = true})
      end
    }
)

-- Go format
vim.api.nvim_create_autocmd(
    "BufWritePre",
    { pattern = "*.rs",
      group = 'AutoFormatting',
      callback = function()
        vim.lsp.buf.format({async = true})
      end
    }
)

vim.api.nvim_exec([[
    augroup fmt
      autocmd!
      autocmd BufWritePre *.js undojoin | Neoformat
      autocmd BufWritePre *.ts undojoin | Neoformat
      autocmd BufWritePre *.tsx undojoin | Neoformat
      autocmd BufWritePre *.scss undojoin | Neoformat
      autocmd BufWritePre *.html undojoin | Neoformat
    augroup END
]], false)

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      vim.keymap.set("n","gd", vim.lsp.buf.definition,{buffer=0})
      vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next,{buffer=0})
      vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev,{buffer=0})
    end,
  },
})

-- TAILWINDCSS
nvim_lsp.tailwindcss.setup{
 filetypes = { "html", "elm" },
 init_options = {
   userLanguages = {
     elm = "html",
     html = "html"
   }
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        elm = "html",
        html = "html"
      },
      classAttributes = { "class", "className", "classList", "ngClass" },
      experimental = {
        classRegex = {
          "\\bclass[\\s(<|]+\"([^\"]*)\"",
          "\\bclass[\\s(]+\"[^\"]*\"[\\s+]+\"([^\"]*)\"",
          "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
          "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
          "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
          "\\bclassList[\\s\\[\\(]+\"([^\"]*)\"",
          "\\bclassList[\\s\\[\\(]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"([^\"]*)\"",
          "\\bclassList[\\s\\[\\(]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"([^\"]*)\""
        }
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  }
}

local servers = { 'tsserver', 'gopls' }

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = function(client)
          vim.keymap.set("n","K", vim.lsp.buf.hover,{buffer=0})
          vim.keymap.set("n","gd", vim.lsp.buf.definition,{buffer=0})
          vim.keymap.set("n","gr", vim.lsp.buf.references,{buffer=0})
          vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next,{buffer=0})
          vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev,{buffer=0})
          vim.keymap.set("n","<leader>r", vim.lsp.buf.rename,{buffer=0})
        end,
    }
end

-- (https://github.com/elm-tooling/elm-language-server/issues/503#issuecomment-773922548)
local custom_attach = function(client)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
  vim.keymap.set("n","K", vim.lsp.buf.hover,{buffer=0})
  vim.keymap.set("n","gd", vim.lsp.buf.definition,{buffer=0})
  vim.keymap.set("n","gr", vim.lsp.buf.references,{buffer=0})
  vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next,{buffer=0})
  vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev,{buffer=0})
  vim.keymap.set("n","<leader>r", vim.lsp.buf.rename,{buffer=0})
end

nvim_lsp.elmls.setup{
  capabilities = capabilities,
  on_attach = custom_attach
}


-- AUTO COMPLETE
vim.opt.completeopt={"menu", "menuone", "noselect"}

  -- Set up nvim-cmp.

local cmp = require"cmp"
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  -- window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  -- },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})
