--[[ Tooling: Install 3rd party tools & Treesitter language modules ]]

local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local message
local info = vim.log.levels.INFO

local masonPackages = require('grs.plugins.tooling.utils').masonPackages()

return {

   --  Mason package manager infrastructure used to install/upgrade
   --  3rd party tools like LSP & DAP servers and Null-ls builtins.
   { 'williamboman/mason.nvim',
      cmd = { 'Mason', 'MasonUpdate' },
      keys = {{ '<leader>mm', '<cmd>Mason<cr>', desc = 'Mason Tool Manager' }},
      config = function()
         require('mason').setup {
            ui = {
               icons = {
                  package_installed = '✓',
                  package_pending = '➜',
                  package_uninstalled = '✗',
               },
            },
         }
      end,
      build = ':MasonUpdate'
   },

   -- Install & update Mason packages on neovim startup
   { 'WhoIsSethDaniel/mason-tool-installer.nvim',
      dependencies = {
         'williamboman/mason.nvim',
         'rcarriga/nvim-notify',
      },
      event = 'VeryLazy',
      keys = {
         { '<leader>mi', '<cmd>MasonToolsInstall<cr>', desc = 'Install tools if missing or wrong version' },
         { '<leader>mu', '<cmd>MasonToolsUpdate<cr>', desc = 'Install missing and update already installed tools' },
      },
      config = function()
         local grsMasonGrp = autogrp('GrsMason', { clear = true })

         autocmd('User', {
            pattern = 'MasonToolsStartingInstall',
            callback = function()
               vim.schedule(function()
                  message = '● mason-tool-installer is starting!'
                  vim.notify(message, info)
               end)
            end,
            group = grsMasonGrp,
            desc = 'Give feedback when updating Mason tools',
         })

         autocmd('User', {
            pattern = 'MasonToolsUpdateCompleted',
            callback = function()
               vim.schedule(function()
                  message = '● mason-tool-installer has finished!'
                  vim.notify(message, info)
               end)
            end,
            group = grsMasonGrp,
            desc = 'Give feedback when Mason tools are finished updating',
         })

         --[[ Configure mason-tool-installer ]]
         require('mason-tool-installer').setup {
            ensure_installed = masonPackages,
            auto_update = true,
            run_on_start = true,
            start_delay = 2000, -- 2 second delay
            debounce_hours = 5, -- at least 5 hour between attempts
         }
      end,
   },

}
