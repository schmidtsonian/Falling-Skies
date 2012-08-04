local _M = display.newGroup()
_M.level = 1
_M.velocity = 2000

local _createPlayer, _createChunks, _createBg, _createMenu

local _onCollision

_createPlayer = function()
	local g = display.newGroup()

	g.body = display.newRect( g, 0, 0, 50, 50 )

	g:setReferencePoint( display.BottomCenterReferencePoint )
	return g
end

_createChunks = function()
	local g = display.newGroup()
	return g
end

_createMenu = function()
	local g = display.newGroup()
	return g
end

_createBg = function()
	local g = display.newGroup()
	return g
end

_onCollision = function( e )
end

_onFrame = function( e )
end

function _M:new()

	-- Setup bg
	self.bg = _createBg()

	-- Setup player
	self.player = _createPlayer()
	self.player.x = MIDDLE_WIDTH
	self.player.y = SH_VIEW - 20

	-- Setup chunks
	self.chunks = _createChunks()

	-- Setup menu
	self.menu = _createMenu()

	-- Setup positions
	self:insert( self.bg )
	self:insert( self.player )
	self:insert( self.chunks )
	self:insert( self.menu )

	-- Listeners
	Runtime:addEventListener( "enterFrame", _onFrame )
	Runtime:addEventListener( "collision", _onCollision )
end

return _M