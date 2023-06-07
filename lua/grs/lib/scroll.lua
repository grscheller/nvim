--[[ Automatic scrolling in window ]]

local up = 'normal <c-y>'
local dn = 'normal <c-e>'
local sleep_more = 1.5
local sleep_less = 2.0/3.0

local M = {
   sleep = 1000,
   timer = nil,
   direction = dn,
}

function M.start()
   print(M.sleep)
   M.timer = vim.loop.new_timer()
   M.timer:start(
      1000,
      M.sleep,
      vim.schedule_wrap(function()
         vim.cmd(vim.api.nvim_replace_termcodes(M.direction, true, true, true))
      end)
   )
end

function M.end_it()
   if M.timer ~= nil then
      M.timer:close()
      M.timer = nil
   end
end

local change = function(n, direction)
   M.end_it()
   M.sleep = M.sleep * n
   M.direction = direction
   M.start()
end

function M.up()
   if M.direction == up then
      change(sleep_less, up)
   else
      change(1, up)
   end
end

function M.down()
   if M.direction == dn then
      change(sleep_less, dn)
   else
      change(1, dn)
   end
end

function M.slower()
   change(sleep_more, M.direction)
end

function M.reset()
   M.end_it()
   M.sleep = 1000
   M.direction = dn
end

return M
