--[[ Refactoring.nvim, Refactoring library based on Martin Fowler's book ]]

return {

   {
      'ThePrimeagen/refactoring.nvim',
      keys = {
         { '<leader>rr',
            function()
               require('refactoring').select_refactoring()
            end,
            mode = 'v',
            noremap = true,
            silent = true,
            expr = false,
            desc = 'select refactoring',
         },
      },
      opts = {},
   },

}
