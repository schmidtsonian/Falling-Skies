 local composer = require "composer"
 
 local scene = composer.newScene()
 
 function scene:create( e )
	print(e.params.level, e.params.kills, e.params.bullets) 
    local sceneGroup = self.view

    sceneGroup.title = display.newText("GAME OVER", MIDDLE_WIDTH, MIDDLE_HEIGHT - 100, FONT_BOLD, 32)
    sceneGroup.level = display.newText("Level: " .. e.params.level, MIDDLE_WIDTH, MIDDLE_HEIGHT - 50, FONT_BOLD, 24)
    sceneGroup.kills = display.newText("Kills: " .. e.params.kills, MIDDLE_WIDTH, sceneGroup.level.y + 30, FONT_BOLD, 24)
    sceneGroup.bullets = display.newText("Bullets: " .. e.params.bullets, MIDDLE_WIDTH, sceneGroup.kills.y + 30, FONT_BOLD, 24)
    
    sceneGroup.btRestart = Widget.newButton( {
        left = MIDDLE_WIDTH - 90,
        top = MIDDLE_HEIGHT + 50,
        id = "btRestart",
        label = "Re",
        emboss = false,
        shape = "roundedRect",
        width = 60,
        height = 60,
        cornerRadius = 0,
        fillColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
        onEvent = function() composer.gotoScene("scenes.Hud", fade, 400) end
    } )
    
    sceneGroup.btHome = Widget.newButton( {
        left = MIDDLE_WIDTH + 30,
        top = MIDDLE_HEIGHT + 50,
        id = "btHome",
        label = "Ho",
        emboss = false,
        shape = "roundedRect",
        width = 60,
        height = 60,
        cornerRadius = 0,
        fillColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
        onEvent = function() composer.gotoScene("scenes.Home", fade, 400) end
    } )
    
    sceneGroup:insert(sceneGroup.title)
    sceneGroup:insert(sceneGroup.level)
    sceneGroup:insert(sceneGroup.kills)
    sceneGroup:insert(sceneGroup.bullets)
    
    sceneGroup:insert(sceneGroup.btRestart)
    sceneGroup:insert(sceneGroup.btHome)
    
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end

-- "scene:show()"
function scene:show( e )

    local sceneGroup = self.view
    local phase = e.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
    
        composer.removeScene( "scenes.Hud" )
        print("----------------scene show GAMEOVER did")
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end

function scene:hide( e )

    local sceneGroup = self.view
    local phase = e.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end

function scene:destroy( e )

    local sceneGroup = self.view

    sceneGroup.title:removeSelf()
    sceneGroup.level:removeSelf()
    sceneGroup.kills:removeSelf()
    sceneGroup.bullets:removeSelf()
    
    sceneGroup.btRestart:removeSelf()
    sceneGroup.btHome:removeSelf()
    
    scene:removeEventListener( "create", scene )
    scene:removeEventListener( "show", scene )
    scene:removeEventListener( "hide", scene )
    scene:removeEventListener( "destroy", scene )
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene