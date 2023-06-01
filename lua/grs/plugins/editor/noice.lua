--[[ Noice.nvim, replaces UI for messages, cmdline & popupmenu ]]

return {

   -- going with suggested setup
   {
      'folke/noice.nvim',
      event = 'VeryLazy',
      dependencies = {
         'MunifTanjim/nui.nvim',
         'rcarriga/nvim-notify',
      },
      opts = {
         lsp = {
            override = {
               ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
               ['vim.lsp.util.stylize_markdown'] = true,
               ['cmp.entry.get_documentation'] = true,
            },
         },
         -- TODO: see smjonas/inc-rename.nvim 
         presets = {
            bottom_search = false,  -- use "classic" botton cmdline for search
            command_palette = true,  -- position the cmdline & poppupmenu together
            long_message_to_split = true,  -- long messages sent to a split
            inc_rename = false,  -- enable input dialog for inc-rename.nvim
            lsp_doc_border = true,  -- add borders to hover docs & signature help
         },
      },
   }

}
