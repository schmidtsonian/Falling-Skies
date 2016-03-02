local _M = {}
local mainGroup = display.newGroup()

-- modules
local Player = require "modules.Player"
local Enemies = require "modules.Enemies"
local Pause = require "modules.Pause"
local GameOver = require "modules.GameOver"
local Stats = require "modules.Stats"
local Countdown = require "modules.Countdown"
local DropObjects = require "modules.DropObjects"

local player, enemies, pause, gameOver, stats, countdown, object

-- events
local onGlobalCollision, onGameOver, onPause, pauseAll, resumeAll, restartAll




onGameOver = function()
    
    pauseAll()
    player:dead()
    pause:lock();
    gameOver:open(stats.stats)
end

onPause = function()
    print("pause!")
    pauseAll()
end

pauseAll = function()
    player:pause()
    enemies:pause()
    stats:pause()
end

resumeAll = function()

    player:resume()
    enemies:resume()
    stats:resume()
end

restartAll = function()

    player:restart()
    enemies:restart()
    stats:restart()
    pause:unlock();
    resumeAll()
end

-- m0015d05eab7b
-- 0015d05eab7b
-- motorola

onGlobalCollision = function( e )
    
    
    local function handleEnemy(enemy, bullet)
        
        enemy.healt = enemy.healt - bullet.power
        enemy.text.text = enemy.healt 
        
        if enemy.healt <= 0 then
            stats:updateKill()
            -- if stats.stats.kills == 2  then
                object:drop("gun", enemy.x, enemy.y)
            -- end
            transition.cancel( enemy )
            enemies.level = stats.stats.level
        end
    end

    if e.object1.name == "enemy" and e.object2.name == "bullet" then handleEnemy(e.object1, e.object2) transition.cancel(e.object2)
    elseif e.object2.name == "enemy" and e.object1.name == "bullet" then handleEnemy(e.object2, e.object1) transition.cancel(e.object1)
    
    elseif e.object1.name == "player" and e.object2.name == "enemy" then onGameOver() 
    elseif e.object2.name == "player" and e.object1.name == "enemy" then onGameOver()
    
    elseif e.object1.name == "player" and e.object2.name == "gun" then
        transition.cancel(e.object2)
        player:upgradeWeapon() 
    elseif e.object2.name == "player" and e.object1.name == "gun" then
        transition.cancel(e.object1)
        player:upgradeWeapon()
    end
    
end


function _M:new()


    player = Player:new("player", mainGroup, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50)
    enemies = Enemies:new("enemy", mainGroup)
    stats = Stats:new(mainGroup)
    
    pause = Pause:new(mainGroup)
    gameOver = GameOver:new(mainGroup)
    countdown = Countdown:new(mainGroup)
    object = DropObjects:new(mainGroup)

    pause.onPause = onPause
    pause.onResume = function() countdown:start(resumeAll) end
    pause.onRestart = function() countdown:start(restartAll) end
    gameOver.onRestart = function() countdown:start(restartAll) end
    
    player:start()
    enemies:start()
    stats:start()
    countdown:start(resumeAll)
    
    Runtime:addEventListener( "collision", onGlobalCollision )
end

return _M