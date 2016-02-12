local _M = {}
local mainGroup = display.newGroup()


local Player = require "modules.Player"
local Enemies = require "modules.Enemies"
local Pause = require "modules.Pause"
local GameOver = require "modules.GameOver"

local stats = { 
    level = 1, 
    kills = 2, 
    bullets = 3 
}

local player, enemies, pause, gameOver

local onGlobalCollision, onGameOver, onPause, pauseAll, resumeAll, restartAll




onGameOver = function()
    
    pauseAll()
    gameOver:open()
end

onPause = function()
    print("pause!")
    pauseAll()
end

pauseAll = function()
    player:pause()
    enemies:pause()
end

resumeAll = function()

    print("resume all")
    player:resume()
    enemies:resume()
end

restartAll = function()

    print("restart all")
    player:restart()
    enemies:restart()
    resumeAll()
end

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
    
    elseif e.object1.name == "player" then onGameOver() 
    elseif e.object2.name == "player" then onGameOver()
    end
    
end





function _M:new()


    player = Player:new("player", mainGroup, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50)
    enemies = Enemies:new("enemy", mainGroup)
    pause = Pause:new(mainGroup)
    gameOver = GameOver:new(mainGroup)

    pause.onPause = onPause
    pause.onResume = resumeAll
    pause.onRestart = restartAll
    gameOver.onRestart = restartAll
    
    player:start()
    enemies:start()
    
    Runtime:addEventListener( "collision", onGlobalCollision )
    
    resumeAll()
end

return _M