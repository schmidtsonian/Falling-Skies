--[[
	Version: 0.1
	Name: Playground
	Description:

]]--

Player = require "modules.Player"

local M = display.newGroup()
local player

-- Initial settings
M.level = 1
M.speed = 3000


-- Constructor
function M:new()
    player = Player:new("player", self, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50)
    
    player:start()
    player:resume()
end

return M