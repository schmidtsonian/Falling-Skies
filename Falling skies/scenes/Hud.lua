--[[
	Version: 0.1
	Name: Playground
	Description:

]]--
local options = {
    effect = "fade",
    time = 800,
    params = { level = 1, kills = 2, bullets = 3 }
}
-- composer.gotoScene("scenes.GameOver", options) 

local composer = require "composer"
local scene = composer.newScene()

-- modules
local Player = require "modules.Player"
local Enemies = require "modules.Enemies"
local Pause = require "modules.Pause"

local player, enemies, pause, pauseAll, resumeAll, restartAll

-- events
local onGlobalCollision, onDead, onPause

onDead = function()
    
    print("game over")
    pauseAll()
    composer.gotoScene("scenes.GameOver", options)
end

onPause = function()
    
    pauseAll()
    pause:open()
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
    
    elseif e.object1.name == "player" then onDead() 
    elseif e.object2.name == "player" then onDead()
    end
    
end

function scene:create( event )

    local sceneGroup = self.view

    player = Player:new("player", sceneGroup, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50)
    enemies = Enemies:new("enemy", sceneGroup)
    pause = Pause:new(sceneGroup, onPause)
    pause.onResume = resumeAll
    pause.onRestart = restartAll
    
    player:start()
    enemies:start()
    
    Runtime:addEventListener( "collision", onGlobalCollision )
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        print("----------------scene show HUD did")
        composer.removeHidden()
        resumeAll()
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end



function scene:destroy( event )

    local sceneGroup = self.view
    
    scene:removeEventListener( "create", scene )
    scene:removeEventListener( "show", scene )
    scene:removeEventListener( "hide", scene )
    scene:removeEventListener( "destroy", scene )
    
    print("destroy HUD")
    
    -- player:destroy()

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene