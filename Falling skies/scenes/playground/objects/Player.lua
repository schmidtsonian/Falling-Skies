local Player = {}
Player.__index = Player

function Player.new(params)
    local self = setmettable({}, Player)
    self.params = params

    -- player    
    self.body = display.newRect( params.mainGroup , params.x, params.y, params.width, params.height )
    self.body.anchorX = 0.5
    self.body.anchorY = 0.5
    self.body.type = "player"
    self.body.halfWidth = self.body.width / 2
    Physics.addBody( self.body, "dynamic", {isSensor = false, density = 1.0, friction = 1, bounce = 0} )
    
    -- bullets
    self.bullets = {}
    
    -- timmers
    self.timerShooting
    
    -- pause
    self.isPause = true

    return self
end

function Player.shoot()

    local bullet = display.newRect( self.body.x, self.body.y - 80, 10, 20 )
    self.mainGroup:insert(bullet)
    Physics.addBody ( bullet, "kynematic", {isSensor = true, density = 1.0, friction = 1, bounce = 0} )
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
    self.bullets[#self.bullets+1] = bullet
end

function Player.pause()
    
    self.isPause = true
    timer.pause( self.timerShooting )
end

function Player.resume()

    timer.resume(.timerShooting)
    self.isPause = false
end


function Player.move(e)

    if self.isPause then return end
    
    if e.phase == "began" then
        
         -- store x location of object
        self.body.markX = self.body.x

    elseif e.phase == "moved" then

        local x = (e.x - e.xStart) + self.body.markX
        if x < SW_VIEW_ORIGIN + self.body.halfWidth then
            x = SW_VIEW_ORIGIN + self.body.halfWidth;
        elseif x > SW_VIEW - self.body.halfWidth then
            x = SW_VIEW - self.body.halfWidth
        end
        self.body.x = x 
    end

    return true
end

function Player.start()

    self.timerShooting = timer.performWithDelay( 150, self:shoot, -1 )
    Runtime:addEventListener( "touch", self:move )
end