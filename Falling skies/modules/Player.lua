
-- Module table
local _M = {}

function _M:new(name, mainGroup, x, y, width, height)

    -- handler
    local handler = {}
    handler.isPaused = false
    handler.bulletSpeed = 550
    handler.bulletReach = -50
    
    
    local body = {}
    local bullets = {}
    local timerShoot
    local gunLevel = 1
    
    local deadSound = audio.loadSound( "sfx/Dead.wav" )
    local bulletSound = audio.loadSound( "sfx/Laser_Shoot36.wav" )
    local upgradeWeapon = audio.loadSound( "sfx/Upgrade_Weapon.wav" )


    -- body
    body = display.newRect( mainGroup , x, y, width, height )
    body.anchorX = 0.5
    body.anchorY = 0.5
    body.name = name
    body.halfWidth = body.width / 2
    Physics.addBody( body, "dynamic", {isSensor = false, density = 1.0, friction = 1, bounce = 0} )
    
    -- priva methods
    local function shoot()
    
        local bullet = display.newRect( body.x, body.y - 80, 10, 20 )
        mainGroup:insert(1, bullet)
        Physics.addBody ( bullet, "kynematic", {isSensor = true, density = 1.0, friction = 1, bounce = 0} )
        bullet.name = 'bullet'
        bullet.power = 1
        
        if gunLevel >= 2 then
            bullet.power = 2
        end
        
        bullet.trans =  transition.to( bullet, { x = bullet.x, time = handler.bulletSpeed, y = handler.bulletReach,
            onStart =
                    function()
                        audio.play( bulletSound )
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
    
    local function move(e)
    
        if handler.isPaused then return false end
    
        if e.phase == "began" then
            
            body.markX = body.x

        elseif e.phase == "moved" then

            local x = (e.x - e.xStart) + body.markX
            if x < SW_VIEW_ORIGIN + body.halfWidth then
                x = SW_VIEW_ORIGIN + body.halfWidth;
            elseif x > SW_VIEW - body.halfWidth then
                x = SW_VIEW - body.halfWidth
            end
            body.x = x 
        end

        return true
    end
    
    function handler:upgradeWeapon()
        gunLevel = gunLevel + 1
        audio.play( upgradeWeapon )
    end
    
    function handler:restart()
        
        for i,bullet in pairs(bullets) do
            transition.cancel(bullet.trans)
        end
        gunLevel = 1
        handler.isPaused = false
        body.x = MIDDLE_WIDTH
    end
    
    function handler:pause()

        handler.isPaused = true
        timer.pause( timerShoot )
        
        for i,bullet in pairs(bullets) do
            transition.pause(bullet.trans)
        end
    end

     function handler:resume()

        for i,bullet in pairs(bullets) do
            transition.resume(bullet.trans)
        end
        timer.resume(timerShoot)
        handler.isPaused = false
    end
    
    function handler:start()
        
        timerShoot = timer.performWithDelay( 150, shoot, -1 )
        Runtime:addEventListener( "touch", move )
        
        handler.pause()
    end
    
    function handler:dead()
        audio.play( deadSound )
    end
    
    return handler
end

return _M