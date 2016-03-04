
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
    
        local w = 10
        local h = 10
        local power = 1
        
        if gunLevel == 2 then
            power = 2
            h = 20
        elseif gunLevel == 3 then
            power = 3
            w = 15
            h = 20
        elseif gunLevel == 4 then
            power = 4
            w = 25
            h = 25
        elseif gunLevel >= 5 then
            power = 2.5
            -- w = 25
            -- h = 25
        end
        
        if gunLevel == 5 then
        
            local x = body.x - 15
            
            for i = 1, 2 do
            
                local bullet = display.newRect( x, body.y - 80, w, h )
                mainGroup:insert(1, bullet)
                Physics.addBody ( bullet, "kynematic", {isSensor = true, density = 1.0, friction = 1, bounce = 0} )
                bullet.name = 'bullet'
                bullet.power = power
                
                
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
                x = x + 30
            end
        
        else
            local bullet = display.newRect( body.x, body.y - 80, w, h )
            mainGroup:insert(1, bullet)
            Physics.addBody ( bullet, "kynematic", {isSensor = true, density = 1.0, friction = 1, bounce = 0} )
            bullet.name = 'bullet'
            bullet.power = power
            
            
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