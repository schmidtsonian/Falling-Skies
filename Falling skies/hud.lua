--[[
	Version: 0.1
	Name: Heads Up Display
	Description:

]]--

local M = display.newGroup()

-- Initial settings
M.level = 1
M.speed = 1000

-- Bullets
local bullets = {}
local bulletSpeed = 250
local bulletReach = -50

-- Enemy
local enemies = {}
local enemiesSpeed = 200
local enemiesReach = SH + 100

-- Objects
local createPlayer, createChunks, createBg, createMenu, releaseEnemies

-- Events
local onGlobalCollision, onFrame, onTouch

createPlayer = function()
	local g = display.newGroup()

	g.body = display.newRect( g, 0, 0, 50, 50 )
    g.halfWidth = g.body.width / 2
	return g
end

createChunks = function()
	local g = display.newGroup()
	return g
end

createBg = function()
	local g = display.newGroup()
	return g
end

createMenu = function()
	local g = display.newGroup()
	return g
end

onGlobalCollision = function( e )
end

onFrame = function( e )
    local bullet = display.newRect( M.player.x, M.player.y, 10, 20 )
    Physics.addBody ( bullet, "kinematic", {density=0.1, friction=0, bounce=0.0} )
    bullet.isBullet = true
    bullet.isSensor = true
    bullet.type = 'bullet'
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
                    -- print("bullet removed onCancel")
                end ,
        onComplete =
                function()
                    bullet:removeSelf()
                    bullet = nil
                    -- print("bullet removed onComplete")
                end
            })
    bullets[#bullets+1] = bullet
end

releaseEnemies = function(e)
    
    for  i= 0, 4 do
    
        local enemy = display.newRect((MIDDLE_WIDTH / 4) + 60 * i, 0, 50, 50)
        Physics.addBody(enemy, "kinematic", {density=0.1, friction=0, bounce=0.0} )
        enemy.isenemy = true
        enemy.isSensor = true
        enemy.type = 'enemy'
        
        enemy.trans = transition.to( enemy, { x=enemy.x, time=M.speed, y=SH,
            onStart =
                    function()
                        -- play sound
                    end ,
            onCancel =
                    function()
                        enemy:removeSelf()
                        enemy = nil
                        -- print("bullet removed onCancel")
                    end ,
            onComplete =
                    function()
                        enemy:removeSelf()
                        enemy = nil
                        -- print("bullet removed onComplete")
                    end
                })
        enemies[#enemies+1] = enemy
    end
end

onTouch = function(e)
    if e.phase == "began" then
        
        M.player.markX = M.player.x    -- store x location of object
    elseif e.phase == "moved" then

        local x = (e.x - e.xStart) + M.player.markX
        if x < M.player.halfWidth then
            x = M.player.halfWidth;
        elseif x > SW - M.player.halfWidth then
            x = SW-M.player.halfWidth
        end
        M.player.x = x 
    end

    return true
end

-- Constructor
function M:new()

	-- Setup bg
	self.bg = createBg()

	-- Setup player
	self.player = createPlayer()
	self.player.x = MIDDLE_WIDTH
	self.player.y = SH_VIEW - 20

	-- Setup chunks
	self.chunks = createChunks()

	-- Setup menu
	self.menu = createMenu()

	-- Setup positions
	self:insert( self.bg )
	self:insert( self.player )
	self:insert( self.chunks )
	self:insert( self.menu )

	-- Listeners
	Runtime:addEventListener( "enterFrame", onFrame )
	Runtime:addEventListener( "collision", onGlobalCollision )
	Runtime:addEventListener( "touch", onTouch )
    timer.performWithDelay( M.speed, releaseEnemies, -1)
end

return M