--[[
	Version: 0.1
	Name: Heads Up Display
	Description:

]]--

local _M = display.newGroup()

-- Initial settings
_M.level = 1
_M.velocity = 2000

-- Bullets
local bullets = {}
local bulletSpeed = 700
local bulletReach = -50

-- Objects
local _createPlayer, _createChunks, _createBg, _createMenu

-- Events
local _onCollision, _onFrame, _onTouch

_createPlayer = function()
	local g = display.newGroup()

	g.body = display.newRect( g, 0, 0, 50, 50 )
    g.halfWidth = g.body.width / 2;

	-- g:setReferencePoint( display.BottomCenterReferencePoint )
	return g
end

_createChunks = function()
	local g = display.newGroup()
	return g
end

_createBg = function()
	local g = display.newGroup()
	return g
end

_createMenu = function()
	local g = display.newGroup()
	return g
end

_onCollision = function( e )
end

_onFrame = function( e )
    local bullet = display.newRect( _M.player.x, _M.player.y, 10, 20 )
    Physics.addBody ( bullet, "kinematic", {density=0.1, friction=0, bounce=0.0} )
    -- bullet.isBullet = true
    -- bullet.isSensor = true
    -- bullet.type = 'bullet'
    -- bullet:setLinearVelocity( 0, -2000 )
    
    
    bullet.trans =  transition.to( bullet, { x=bullet.x, time=bulletSpeed, y=bulletReach,
        onStart =
                function()
                    -- play sound
                end ,
        onCancel =
                function()
                    bullet:removeSelf()
                    bullet = nil
                    print("bullet removed onCancel")
                end ,
        onComplete =
                function()
                    bullet:removeSelf()
                    bullet = nil
                    print("bullet removed onComplete")
                end
            })
    bullets[#bullets+1] = bullet
end

_onTouch = function(e)
    if e.phase == "began" then
        
        _M.player.markX = _M.player.x    -- store x location of object
    elseif e.phase == "moved" then

        local x = (e.x - e.xStart) + _M.player.markX
        if x < _M.player.halfWidth then
            x = _M.player.halfWidth;
        elseif x > SW - _M.player.halfWidth then
            x = SW-_M.player.halfWidth
        end
        _M.player.x = x 
    end

    return true
end

-- Constructor
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
	Runtime:addEventListener( "touch", _onTouch )
end

return _M