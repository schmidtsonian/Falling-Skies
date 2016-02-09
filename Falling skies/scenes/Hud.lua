--[[
	Version: 0.1
	Name: Playground
	Description:

]]--

local M = display.newGroup()
-- Initial settings
M.level = 1
M.speed = 3000

-- modules
Player = require "modules.Player"
Enemies = require "modules.Enemies"

local player, enemies

-- events
local onGlobalCollision


onGlobalCollision = function( e )
    
    
    local function handleEnemy(enemy)
        
        enemy.healt = enemy.healt - 1
        enemy.text.text = enemy.healt 
        
        if enemy.healt <= 0 then
            transition.cancel( enemy )
        end
    end


    if e.object1.name == "enemy" and e.object2.name == "bullet" then handleEnemy(e.object1) transition.cancel(e.object2)
    elseif e.object2.name == "enemy" and e.object1.name == "bullet" then handleEnemy(e.object2) transition.cancel(e.object1)
    
    elseif e.object1.name == "player" then --[[onDead()]]-- 
    elseif e.object2.name == "player" then --[[onDead()]]--
    end
    
end

-- Constructor
function M:new()
    player = Player:new("player", M, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50)
    enemies = Enemies:new("enemy", M)
    
    player:start()
    enemies:start()
    
    
    player:resume()
    enemies:resume()
    
    Runtime:addEventListener( "collision", onGlobalCollision )
end

return M