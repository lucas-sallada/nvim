-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
--
local lspconfig = require('lspconfig')

local servers = {
  clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {
    documentFormatting = false
  },
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  angularls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

local _border = "single"

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = _border }),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = _border }),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
      handlers = handlers,
    }
  end
}

lspconfig.cucumber_language_server.setup {
    settings = {
        cucumber = {
          features = { "features/**/**/*.feature" },
          glue = { "src/steps/**/*.steps.ts" }
        },
    },
    root_dir = lspconfig.util.find_git_ancestor(),
    on_attach = on_attach,
}

local cmd = {
    'ngserver',
    '--stdio',
    '--tsProbeLocations',
    '/Users/DKS0662774/.local/share/nvim/mason/packages/angular-language-server/node_modules/@angular/language-server/node_modules,/Users/DKS0662774/workspace/dcsg-ngx-ecommerce/node_modules',
    '--ngProbeLocations',
    '/Users/DKS0662774/.local/share/nvim/mason/packages/angular-language-server/node_modules/@angular/language-server/node_modules,/Users/DKS0662774/workspace/dcsg-ngx-ecommerce/node_modules'
}

lspconfig.angularls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "angular", "angular.html" },
    root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
    cmd = cmd,
    on_new_config = function(new_config, new_root_dir)
      new_config.cmd = cmd
    end
}

-- vim: ts=2 sts=2 sw=2 et
