--[[ Refactoring.nvim, Refactoring library based on Martin Fowler's book ]]

return {

   {
      'ThePrimeagen/harpoon',
      keys = {
         {
            '<leader>hh',
            function()
               require('harpoon.ui').toggle_quick_menu()
            end,
            desc = 'show marks',
         },
         {
            '<leader>hm',
            function()
               require('harpoon.mark').add_file()
            end,
            noremap = true,
            silent = true,
            expr = false,
            desc = 'add mark',
         },
      },
      opts = {
         menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
         },
      },
   },

}
