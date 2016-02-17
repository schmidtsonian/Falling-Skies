local _M = {}

function _M:new(name, mainGroup)
    
    local handler = {}
    handler.isPaused = false
    handler.speed = 3000
    handler.enemiesSpeed = 3000
    handler.enemiesReach = SH_VIEW + 100
    handler.level = 0
    
    local deadSound = audio.loadSound( "sfx/Enemy_Dead.wav" )
    
    local enemies = {}
    local timerDisplayEnemies
    
    local function releaseEnemies()
        
        local healtMin = 5
        local enemyMin = {0}
        -- level 4
        if handler.level == 4 then
            enemyMin = {math.random(4), math.random(4), math.random(4)}
        elseif handler.level == 5 then
            enemyMin = {math.random(4), math.random(4)}
        end
        
        for i = 0, 4 do
    
            local enemy = display.newRect((MIDDLE_WIDTH / 4) + 60 * i, -100, 50, 50)
            Physics.addBody(enemy, "dynamic", {radiys= 50, isSensor = true, density = 1.0, friction = 1, bounce = 0} )
            mainGroup:insert(1, enemy)
            enemy.name = name
            if handler.level == 0 then
                enemy.healt = 2
            elseif handler.level == 1 then
                enemy.healt = 3
            elseif handler.level == 2 then
                enemy.healt = 4
            elseif handler.level == 3 then
                enemy.healt = 5
            else
                if i == enemyMin[1] or i == enemyMin[2] or i == enemyMin[3] then
                    enemy.healt = healtMin
                else
                    enemy.healt = 10
                end
            end
            
            enemy.text = display.newText(enemy.healt, enemy.x, enemy.y, FONT_BOLD, 32)
            mainGroup:insert(2, enemy.text)
            enemy.text:setFillColor(0, 0, 0)
            
            enemy.transText = transition.to(enemy.text, { x = enemy.x, time = handler.enemiesSpeed, y = handler.enemiesReach } )
            enemy.transBody = transition.to(enemy, { x = enemy.x, time = handler.enemiesSpeed, y = handler.enemiesReach,
                onStart =
                        function()
                            
                        end ,
                onCancel =
                        function()
                            enemy.text:removeSelf()
                            enemy:removeSelf()
                            enemy = nil
                            
                            audio.play(deadSound)
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
        print("---")
    end

    -- public methods
    function handler:restart()
        
        for i,enemy in pairs(enemies) do
            transition.cancel(enemy.transBody)
            transition.cancel(enemy.transText)
        end
        handler.isPaused = false
    end
    
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