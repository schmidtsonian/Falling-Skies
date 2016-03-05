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

local logo, player, enemies, pause, gameOver, stats, countdown, object

-- events
local start, removeHome, onGlobalCollision, onGameOver, onPause, pauseAll, resumeAll, restartAll




onGameOver = function()
    print("game over")
    pauseAll()
    player:dead()
    pause:lock();
    enemies:restart()
    gameOver:open(stats.stats)
end

onPause = function()
    print("pause!")
    pauseAll()
end

pauseAll = function()
    Physics.pause()
    player:pause()
    enemies:pause()
    stats:pause()
    object.pause()
end

resumeAll = function()

    Physics.start()
    player:resume()
    enemies:resume()
    stats:resume()
    object.resume()
end

restartAll = function()

    player:restart()
    enemies:restart()
    stats:restart()
    object:restart()
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
            if stats.stats.kills == 2 or stats.stats.kills == 12 or stats.stats.kills == 24 or stats.stats.kills == 25  then
                object:drop("gun", enemy.x, enemy.y)
            end
            transition.cancel( enemy )
            enemies.level = stats.stats.level
        end
    end

    if e.object1.name == "enemy" and e.object2.name == "bullet" then handleEnemy(e.object1, e.object2) transition.cancel(e.object2)
    elseif e.object2.name == "enemy" and e.object1.name == "bullet" then handleEnemy(e.object2, e.object1) transition.cancel(e.object1)
    
    elseif e.object1.name == "player" and e.object2.name == "gun" then
        
        transition.cancel(e.object2)
        stats:updateWeapon()
        player:upgradeWeapon() 
    elseif e.object2.name == "player" and e.object1.name == "gun" then
        transition.cancel(e.object1)
        stats:updateWeapon()
        player:upgradeWeapon()
        
    elseif e.object1.name == "player" and e.object2.name == "enemy" then onGameOver() 
    elseif e.object2.name == "player" and e.object1.name == "enemy" then onGameOver()
    end
    
end


start = function()

    player = Player:new("player", mainGroup, MIDDLE_WIDTH, SH_VIEW - 65, 50, 50)
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

removeHome = function()

    Runtime:removeEventListener( "touch", removeHome )
    
    transition.to( logo, { y = -200, onComplete = start })
end 


function _M:new()

    logo = display.newImage( 'images/logo-falling-skies.png'  )
    logo.anchorX = 0.5
    logo.anchorY = 0.5
    logo.width = 280
    logo.height = 153
    logo.x = MIDDLE_WIDTH
    logo.y = MIDDLE_HEIGHT
    
    Runtime:addEventListener( "touch", removeHome )
end





return _M