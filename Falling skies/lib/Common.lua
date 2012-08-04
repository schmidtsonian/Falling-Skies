
VERSION = "1.0"

SH = 480
SW = 320

BG_SH = 570
BG_SW = 380

MIDDLE_WIDTH = SW / 2
MIDDLE_HEIGHT = SH / 2

SW_VIEW_ORIGIN = display.screenOriginX
SH_VIEW_ORIGIN = display.screenOriginY

SW_VIEW = SW; if SW_VIEW_ORIGIN < 0 then SW_VIEW = SW + ( SW_VIEW_ORIGIN * -1 ) end
SH_VIEW = SH; if SH_VIEW_ORIGIN < 0 then SH_VIEW = SH + ( SH_VIEW_ORIGIN * -1 ) end

FONT_1 = native.systemFont

_cleanTransitions = function()
	tnt:cancelAllTransitions()
	tnt:cancelAllTimers()
	tnt:cleanTimersAndTransitions()
end

_doTransitionBt = function( params )
	local object, xTarget, yTarget, time_delay = 
		params.object, params.xTarget, params.yTarget, params.time_delay
	object.x = -200
	object.y = SH + 200

	tnt:newTransition( object, { x = xTarget, y = yTarget, time = 600, delay = time_delay } )
end

-- Create a button with thext
-- return	Group
_createBt = function( mainGroup, txt, w )
	local g = display.newGroup()
	local width = w or 150
	g.bt = display.newRect( g, 0, 0, width, 50 )
	g.bt:setFillColor( 0, 0, 0 )
	g.bt:setReferencePoint( display.CenterReferencePoint )

	g.txt = display.newText( g, txt, 0, 0, FONT_1, 24 )
	g.txt:setReferencePoint( display.CenterReferencePoint )
	g.txt.x = g.bt.x
	g.txt.y = g.bt.y
	
	g:setReferencePoint( display.CenterReferencePoint )
	
	mainGroup:insert( g )

	return g
end