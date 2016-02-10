local _M = {}

function _M:new(name, mainGroup)
    
    local handler = {}
    handler.isPaused = false
    handler.speed = 3000
    handler.enemiesSpeed = 3000
    handler.enemiesReach = SH_VIEW + 100
    
    local enemies = {}
    local timerDisplayEnemies
    
    local function releaseEnemies()
        
        for  i= 0, 4 do
    
            local enemy = display.newRect((MIDDLE_WIDTH / 4) + 60 * i, -100, 50, 50)
            Physics.addBody(enemy, "dynamic", {radiys= 50, isSensor = true, density = 1.0, friction = 1, bounce = 0} )
            mainGroup:insert(1, enemy)
            enemy.name = name
            enemy.healt = 2
            
            enemy.text = display.newText(enemy.healt, enemy.x, enemy.y, native.systemFontBold, 32)
            mainGroup:insert(2, enemy.text)
            enemy.text:setFillColor(0, 0, 0)
            
            enemy.transText = transition.to(enemy.text, { x = enemy.x, time = handler.enemiesSpeed, y = handler.enemiesReach } )
            enemy.transBody = transition.to(enemy, { x = enemy.x, time = handler.enemiesSpeed, y = handler.enemiesReach,
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

    -- public methods
    function handler:pause()
        
        handler.isPaused = true
        timer.pause( timerDisplayEnemies ) 
        
        for i,enemy in pairs(enemies) do
            transition.pause(enemy.transBody)
            transition.pause(enemy.transText)
        end
    end

     function handler:resume()

        for i,enemy in pairs(enemies) do
            transition.resume(enemy.transBody)
            transition.resume(enemy.transText)
        end
        timer.resume(timerDisplayEnemies)
        handler.isPaused = false
    end
    
    function handler:start()
        
        timerDisplayEnemies = timer.performWithDelay( handler.speed, releaseEnemies, -1)
        handler.pause()
    end
    
    return handler
end

return _M