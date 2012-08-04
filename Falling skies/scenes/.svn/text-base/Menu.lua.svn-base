--[[
	Original Filename: Menu.lua
    Project: Galaxyar 
    Version: 1.0
    Copyright: Fugitive Pixel Studios 2012
    Description: Vista para manejar menú principal
]]--

local scene = storyboard.newScene()

local ui = {}
local _onTouchBt, _createButtons

-- Event buttons
_onTouchBt = function( e )

	if e.phase == "ended" then
		storyboard.gotoScene( e.target.scene, "fade", TIME_CHANGE_SCENE )
	end
end


-- Create a group with buttons navigation
-- return		Group
_createButtons = function()

	local g = display.newGroup()

	ui.btPlay = _createBt( g, "Play" )
	ui.btScore = _createBt( g, "Score" )
	ui.btCredits = _createBt( g, "Credits" )

	ui.btPlay.scene = "scenes.Hud"
	ui.btScore.scene = "scenes.Score"
	ui.btCredits.scene = "scenes.Credits"

	ui.btPlay.x = MIDDLE_WIDTH
	ui.btScore.x = ui.btPlay.x
	ui.btCredits.x = ui.btPlay.x

	ui.btScore.y = MIDDLE_HEIGHT
	ui.btPlay.y = ui.btScore.y - ( ui.btScore.height / 2 ) - 50
	ui.btCredits.y = ui.btScore.y + ( ui.btScore.height / 2 ) + 50

	ui.btPlay:addEventListener( "touch", _onTouchBt )
	ui.btScore:addEventListener( "touch", _onTouchBt )
	ui.btCredits:addEventListener( "touch", _onTouchBt )

	g:insert( ui.btPlay )
	g:insert( ui.btScore )
	g:insert( ui.btCredits )

	-- Settings transitions

	_doTransitionBt( { object = ui.btPlay, xTarget = ui.btPlay.x, yTarget = ui.btPlay.y, time_delay = 1 } )
	_doTransitionBt( { object = ui.btScore, xTarget = ui.btScore.x, yTarget = ui.btScore.y, time_delay = 80 } )
	_doTransitionBt( { object = ui.btCredits, xTarget = ui.btCredits.x, yTarget = ui.btCredits.y, time_delay = 160 } )

	return g
end

function scene:createScene( e )
	print("--Create scene: MENU")
	ui.g = self.view

	ui.bg = display.newRect( ui.g, 0, 0, BG_SW, BG_SH )
	ui.bg.x = MIDDLE_WIDTH
	ui.bg.y = MIDDLE_HEIGHT

	ui.gButtons = _createButtons()

	ui.g:insert( ui.bg )
	ui.g:insert( ui.gButtons )

	--ui.g:setReferencePoint( display.CenterReferencePoint )

end

function scene:enterScene( e )
	print("--Enter scene: MENU")
end

function scene:exitScene( e )
	_cleanTransitions()
	print("--Exit scene: MENU")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )

return scene