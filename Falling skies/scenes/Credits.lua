--[[
	Original Filename: Credits.lua
    Project: Galaxyar 
    Version: 1.0
    Copyright: Fugitive Pixel Studios 2012
    Description: Vista para créditos del juego
]]--

local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true

local scene = storyboard.newScene()

local ui = {}
local _onTouchBt, _createButtons, _createText

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

	ui.btReturn = _createBt( g, "Return" )

	ui.btReturn.x = SW_VIEW_ORIGIN + ( ui.btReturn.width / 2 ) + 25
	ui.btReturn.y = SH_VIEW - ( ui.btReturn.height / 2 ) - 25

	ui.btReturn.scene = "scenes.Menu"
	ui.btReturn:addEventListener( "touch", _onTouchBt )

	g:insert( ui.btReturn )

	-- Settings transitions
	_doTransitionBt( { object = ui.btReturn, xTarget = ui.btReturn.x, yTarget = ui.btReturn.y, time_delay = 1 } )

	return g
end

_createText = function()
	local g = display.newGroup()

	g.txt = display.newText( g, "José Esteban Ramirez Schmidt", 0, 0, FONT_1, 24 )
	g.txt:setReferencePoint( display.CenterReferencePoint )
	g.txt.x = MIDDLE_WIDTH
	g.txt.y = MIDDLE_HEIGHT - 50
	g.txt:setTextColor( 0, 0, 0 )

	return g
end

function scene:createScene( e )
	print("--Create scene: CREDITS")
	ui.g = self.view

	ui.bg = display.newRect( ui.g, 0, 0, BG_SW, BG_SH )
	ui.bg.x = MIDDLE_WIDTH
	ui.bg.y = MIDDLE_HEIGHT

	ui.gButtons = _createButtons()
	
	ui.gText = _createText()

	ui.g:insert( ui.bg )
	ui.g:insert( ui.gButtons )
	ui.g:insert( ui.gText )
end

function scene:enterScene( e )
	print("--Enter scene: CREDITS")
end

function scene:exitScene( e )
	_cleanTransitions()
	print("--Exit scene: CREDITS")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )

return scene