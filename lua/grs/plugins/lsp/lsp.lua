--[[ Configure LSP client with lspconfig & null-ls builtins ]]

-- To provide overrides to customize the default configurations
-- pushed to LSP servers, and Null-ls wrapped tools, edit the first
-- two tables in grs/plugins/lsp/utils.lua.

local km = require 'grs.config.keymaps'

-- LSP servers to manually configure via lspconfig (installed by pacman)
local lspServers = {
   'bashls',
   'clangd',
   'zls',
}

-- NullLS Builtins to configure (installed by pacman)
local nullLsBuiltins = {
   code_actions = {
      'shellcheck',
   },
   completions = {
   },
   diagnostics = {
      'cppcheck',
      'cpplint',
      'selene',
      'spellcheck',
      'yamllint',
   },
   formatting = {
      'stylua',
   },
   hover = {
   },
}

-- NullLS Builtin option overrides
local NullLsBuiltinOpts = {
   yamllint = {
      extra_args = {
         '-d',
         '{extends: default, rules: {key-ordering: "disable", line-length: {max: 100}}}',
      },
   },
}

-- NullLS builtin default options
local NullLSBuiltinOptsMT = {}
NullLSBuiltinOptsMT.__index = function()
   return {}
end

-- NullLS builtin options
setmetatable(NullLsBuiltinOpts, NullLSBuiltinOptsMT)

return {

   -- LSP servers auto-installed via Nix & auto-configured via lspconfig
   {
      'dundalek/lazy-lsp.nvim',
      dependencies = {
      event = { 'BufReadPre', 'BufNewFile' },
         'neovim/nvim-lspconfig',
      },
      config = function()
         local capabilities = require('cmp_nvim_lsp').default_capabilities()

         require('lazy-lsp').setup {
            -- By default all available servers are set up. Exclude unwanted or
            -- misbehaving servers.
            excluded_servers = {
               'bashls',        -- pacman (lspconfig)
               'ccls',          -- using clangd instead
               'clangd',        -- pacman (lspconfig)
               'metals',        -- nvim-metals (directly configures LSP client)
               'rust_analyzer', -- rust-tools (directly uses lspconfig)
               'zls',           -- pacman (lspconfig)
            },
            -- Alternatively specify preferred servers for a filetype, other
            -- servrts will be ignored.
            preferred_servers = {
               markdown = { 'marksman', 'zk' },
               python = { 'pyright' },
            },
            -- Default config passed to all servers to specify on_attach
            -- callback and other options.
            default_config = {
               flags = {
                  debounce_text_changes = 150,
               },
               on_attach = function(_, bufnr)
                  km.lsp(bufnr)
               end,
               capabilities = capabilities,
            },
            -- Override default_config for specific servers that will be passed
            -- to lspconfig setup. Note that these these specific configurations
            -- will be merged into the default_config.
            configs = {
               lua_ls = {
                  settings = {
                     Lua = {
                        diagnostics = { globals = { 'vim' } },
                        completion = { callSnippet = 'Replace' },
                     },
                  },
                  filetypes = { 'lua' },
               },
               hls = {
                  filetypes = { 'haskell', 'lhaskell', 'cabal' },
                  on_attach = function(_, bufnr)
                     km.lsp(bufnr)
                     km.haskell(bufnr)
                  end,
               },
            },
         }
      end,
   },

   -- LSP servers manually installed (Pacman) & manually configured (lspconfig)
   {
      'neovim/nvim-lspconfig',
      dependencies = {
         { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
         { 'folke/neodev.nvim', opts = {} },
      },

      config = function()
         local lspconfig = require 'lspconfig'
         local capabilities = require('cmp_nvim_lsp').default_capabilities()

         -- needs to run before configuring any LSP servers via lspconfig
         require('neoconf').setup {
            experimental = { pathStrict = true },
         }

         -- eagerly configure lsp client for each lsp server individually
         for _, lspServer in ipairs(lspServers) do
            lspconfig[lspServer].setup {
               capabilities = capabilities,
               on_attach = function(_, bufnr)
                  km.lsp(bufnr)
               end,
            }
         end
      end,
   },

   {
      'jose-elias-alvarez/null-ls.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      config = function()
         local null_ls = require 'null-ls'

         local nullLsSources = {}
         for nullLsType, builtins in pairs(nullLsBuiltins) do
            for _, builtin in ipairs(builtins) do
               table.insert(
                  nullLsSources,
                  null_ls.builtins[nullLsType][builtin].with(NullLsBuiltinOpts[builtin])
               )
            end
         end

         -- setup null-ls for all builtin configurations at once
         null_ls.setup {
            sources = nullLsSources,
         }
      end,
   },

}
