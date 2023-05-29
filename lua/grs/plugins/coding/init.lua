--[[ Configure plugins to assist in software development & refactoring ]]

local iFlatten = require('grs.lib.functional').iFlatten

return iFlatten {
   require 'grs.plugins.coding.refactoring',
   require 'grs.plugins.coding.harpoon',
}
