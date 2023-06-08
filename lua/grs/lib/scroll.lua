--[[ Automatic scrolling in window ]]

local up = 'normal <c-y>'
local dn = 'normal <c-e>'
local sleep_more = 1.5
local sleep_less = 2.0/3.0

local M = {
   sleep = 1000,
   direction = dn,
   timer = nil,
}

local del_timer = function()
   if M.timer ~= nil then
      M.timer:close()
      M.timer = nil
   end
end

local new_timer = function()
   del_timer()
   M.timer = vim.loop.new_timer()
   M.timer:start(
      1000,
      M.sleep,
      vim.schedule_wrap(function()
         vim.cmd(vim.api.nvim_replace_termcodes(M.direction, true, true, true))
      end)
   )
end

local change = function(n, direction)
   M.sleep = M.sleep * n
   M.direction = direction
   new_timer()
end

function M.up()
   change(1, up)
end

function M.down()
   change(1, dn)
end

function M.pause()
   del_timer()
end

function M.reset()
   M.sleep = 1000
   M.direction = dn
   del_timer()
end

function M.slower()
   if M.timer then
      change(sleep_more, M.direction)
   end
end

function M.faster()
   if M.timer then
      change(sleep_less, M.direction)
   end
end

return M
