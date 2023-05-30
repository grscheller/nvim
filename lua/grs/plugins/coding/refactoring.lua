--[[ Refactoring.nvim, Refactoring library based on Martin Fowler's book ]]
--
-- !!!CURRENTLY NOT IN NVIM CONFIGURATION!!!
--
-- This one will require a bit of a learning curve.  Will come back later after
-- I have gotten other lower hanging fruit.
--

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
