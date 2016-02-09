--[[
	Version: 0.1
	Name: Playground
	Description:

]]--

Player = require "modules.Player"
Enemies = require "modules.Enemies"

local M = display.newGroup()
local player, enemies

-- Initial settings
M.level = 1
M.speed = 3000


-- Constructor
function M:new()
    player = Player:new("player", self, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50)
    enemies = Enemies:new("enemy", self)
    
    player:start()
    enemies:start()
    
    
    player:resume()
    enemies:resume()
end

return M