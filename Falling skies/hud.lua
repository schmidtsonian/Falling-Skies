--[[
	Version: 0.1
	Name: Heads Up Display
	Description:

]]--



function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end



local M = display.newGroup()

-- Initial settings
M.level = 1
M.speed = 3000

-- Bullets
local bullets = {}
local bulletSpeed = 550
local bulletReach = -50

-- Enemy
local enemies = {}
local enemiesSpeed = 200
local enemiesReach = SH + 100



-- Player
local player

-- Functions
local createPlayer, createChunks, createBg, createMenu, releaseEnemies, pause, onDead

-- Events
local onGlobalCollision, shoot, onTouch, onCollision

-- Timers
local timerShooting, timerEnemies

local isPause = fale;

pause = function()

    isPause = true;
    
    timer.pause( timerShooting )
    timer.pause( timerEnemies )
    
    for i,enemy in pairs(enemies) do
        transition.pause(enemy.transBody)
        transition.pause(enemy.transText)
    end
    
    for i,bullet in pairs(bullets) do
        transition.pause(bullet.trans)
    end
    -- for pos,val in pairs(enemies) do
    -- end
end

onDead = function()
    print("game over")
    pause();
end

createPlayer = function()
    player = display.newRect( M, MIDDLE_WIDTH, SH_VIEW - 20, 50, 50 )
    player.anchorX = 0.5
    player.anchorY = 0.5
	
    Physics.addBody( player, "dynamic", {isSensor = false, density = 1.0, friction = 1, bounce = 0} )

    player.halfWidth = player.width / 2
    player.type = "player"
end

createChunks = function()
	local g = display.newGroup()
	return g
end

createBg = function()
	local g = display.newGroup()
	return g
end

local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        pause()
    end
end

createMenu = function()
	local g = display.newGroup()
    
    -- g.btMenu = bt(M, "PAUSE", 60, 30)
    g.btMenu = Widget.newButton( {
        left = 0,
        top = 0,
        id = "button1",
        label = "|| ||",
        emboss = false,
        shape = "roundedRect",
        width = 30,
        height = 30,
        cornerRadius = 0,
        fillColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
        onEvent = handleButtonEvent
    } )
    g.btMenu.x = SW_VIEW - 25
    g.btMenu.y = SH_VIEW_ORIGIN + 25
    
	return g
end

handleEnemy = function(enemy)
    
    enemy.healt = enemy.healt - 1
    enemy.text.text = enemy.healt 
    
    if enemy.healt <= 0 then
        transition.cancel( enemy )
    end
end


onGlobalCollision = function( e )
    
    if e.object1.type == "enemy" and e.object2.type == "bullet" then handleEnemy(e.object1) transition.cancel(e.object2)
    elseif e.object2.type == "enemy" and e.object1.type == "bullet" then handleEnemy(e.object2) transition.cancel(e.object1)
    
    elseif e.object1.type == "player" then onDead() 
    elseif e.object2.type == "player" then onDead()
    end
    
end

onCollision = function (self, e)

    -- print(self, e, "aaa")
end

shoot = function( e )
    local bullet = display.newRect( player.x, player.y - 80, 10, 20 )
    Physics.addBody ( bullet, "kynematic", {isSensor = true, density = 1.0, friction = 1, bounce = 0} )
    M:insert(bullet)
    bullet.type = 'bullet'
    
    bullet.trans =  transition.to( bullet, { x=bullet.x, time=bulletSpeed, y=bulletReach,
        onStart =
                function()
                    -- play sound
                end ,
        onCancel =
                function()
                    bullet:removeSelf()
                    bullet = nil
                end ,
        onComplete =
                function()
                    bullet:removeSelf()
                    bullet = nil
                end
            })
    bullets[#bullets+1] = bullet
end

releaseEnemies = function(e)
    
    for  i= 0, 4 do
    
        local enemy = display.newRect((MIDDLE_WIDTH / 4) + 60 * i, 0, 50, 50)
        Physics.addBody(enemy, "dynamic", {radiys= 50, isSensor = true, density = 1.0, friction = 1, bounce = 0} )
        M:insert(enemy)
        enemy.type = 'enemy'
        enemy.healt = 2
        
        enemy.text = display.newText( enemy.healt, enemy.x, enemy.y, native.systemFontBold, 32 )
        enemy.text:setFillColor( 0, 0, 0 )
        
        enemy.transText = transition.to( enemy.text, { x=enemy.x, time=M.speed, y=SH } )
        enemy.transBody = transition.to( enemy, { x=enemy.x, time=M.speed, y=SH,
            onStart =
                    function()
                        -- play sound
                    end ,
            onCancel =
                    function()
                        enemy.text:removeSelf()
                        enemy:removeSelf()
                        enemy = nil
                    end ,
            onComplete =
                    function()
                        enemy.text:removeSelf()
                        enemy:removeSelf()
                        enemy = nil
                    end
                })
        enemies[#enemies+1] = enemy
    end
end

onTouch = function(e)

    if isPause then return end
    
    if e.phase == "began" then
        
        player.markX = player.x    -- store x location of object
    elseif e.phase == "moved" then

        local x = (e.x - e.xStart) + player.markX
        if x < SW_VIEW_ORIGIN + player.halfWidth then
            x = SW_VIEW_ORIGIN + player.halfWidth;
        elseif x > SW_VIEW - player.halfWidth then
            x = SW_VIEW - player.halfWidth
        end
        player.x = x 
    end

    return true
end

-- Constructor
function M:new()

	-- Setup bg
	self.bg = createBg()

	-- Setup player
	createPlayer()
	-- player.x = MIDDLE_WIDTH
	-- player.y = SH_VIEW - 20

	-- Setup chunks
	self.chunks = createChunks()

	-- Setup menu
	self.menu = createMenu()


    -- Setup pause


	-- Setup positions
	self:insert( self.bg )
	-- self:insert( player )
	self:insert( self.chunks )
	self:insert( self.menu )

	-- Listeners
	Runtime:addEventListener( "touch", onTouch )
	Runtime:addEventListener( "collision", onGlobalCollision )
    -- self.player.collision = onCollision
    -- self:addEventListener( "collision", self.player )
    timerShooting = timer.performWithDelay( 150, shoot, -1 )
    timerEnemies = timer.performWithDelay( M.speed, releaseEnemies, -1)
end

return M