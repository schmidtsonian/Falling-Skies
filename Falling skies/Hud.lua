local _M = {}
local mainGroup = display.newGroup()

-- modules
local Player = require "modules.Player"
local Enemies = require "modules.Enemies"
local Pause = require "modules.Pause"
local GameOver = require "modules.GameOver"
local Stats = require "modules.Stats"
local Countdown = require "modules.Countdown"

local player, enemies, pause, gameOver, stats, countdown

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

onGlobalCollision = function( e )
    
    
    local function handleEnemy(enemy, bullet)
        
        enemy.healt = enemy.healt - bullet.power
        enemy.text.text = enemy.healt 
        
        if enemy.healt <= 0 then
            transition.cancel( enemy )
            stats:updateKill()
            enemies.level = stats.stats.level
        end
    end

    if e.object1.name == "enemy" and e.object2.name == "bullet" then handleEnemy(e.object1, e.object2) transition.cancel(e.object2)
    elseif e.object2.name == "enemy" and e.object1.name == "bullet" then handleEnemy(e.object2, e.object1) transition.cancel(e.object1)
    
    elseif e.object1.name == "player" then onGameOver() 
    elseif e.object2.name == "player" then onGameOver()
    end
    
end


function _M:new()


    player = Player:new("player", mainGroup, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50)
    enemies = Enemies:new("enemy", mainGroup)
    stats = Stats:new(mainGroup)
    
    pause = Pause:new(mainGroup)
    gameOver = GameOver:new(mainGroup)
    countdown = Countdown:new(mainGroup)

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