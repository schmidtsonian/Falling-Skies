
function scene:createScene( e )
end

function scene:enterScene( e )
	storyboard.gotoScene( "scenes.Hud", "crossFade", 1 )
end

function scene:exitScene( e )
	_cleanTransitions()
	storyboard.purgeAll()
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )

