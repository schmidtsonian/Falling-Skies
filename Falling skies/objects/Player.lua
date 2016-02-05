
-- Module table
local _M = {}

function _M:new(name, mainGroup, x, y, width, height)

    -- handler
    local player = {}
    player.isPaused = true
    
    local body = {}
    local bullets = {}
    local timerShooting

    -- body
    body = display.newRect( mainGroup , x, y, width, height )
    body.anchorX = 0.5
    body.anchorY = 0.5
    body.name = name
    body.halfWidth = body.width / 2
    Physics.addBody( body, "dynamic", {isSensor = false, density = 1.0, friction = 1, bounce = 0} )
    
    -- priva methods
    local shoot = function()
    
        local bullet = display.newRect( body.x, body.y - 80, 10, 20 )
        mainGroup:insert(bullet)
        Physics.addBody ( bullet, "kynematic", {isSensor = true, density = 1.0, friction = 1, bounce = 0} )
        bullet.name = 'bullet'
        
        bullet.trans =  transition.to( bullet, { x = bullet.x, time = bulletSpeed, y = bulletReach,
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
    
    local move = function()
    
        if player.isPaused then return false end
    
        if e.phase == "began" then
            
            -- store x location of object
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
    
    
    -- public methods
    player:pause = function()
        
        self.isPaused = true
        timer.pause( timerShooting )
    end

    player:resume = function()

        timer.resume(timerShooting)
        self.isPaused = false
    end
    
    player:start = function()
        
        timerShooting = timer.performWithDelay( 150, shoot, -1 )
        Runtime:addEventListener( "touch", move )
    end

    
    return player
end

return _M