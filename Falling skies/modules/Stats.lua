local _M = {}

function _M:new(mainGroup)

    local handler = {}
    local txtLevel, txtKills, txtTime
    local timerAlive
    handler.stats = { 
        level = 0, 
        kills = 0, 
        time = 0 
    }
    local levelUpSound = audio.loadSound( "sfx/Level_Up.wav" )
    
    txtLevel = display.newText('', SW_VIEW_ORIGIN + 20, SH_VIEW_ORIGIN + 30, FONT_NORMAL, 14)
    txtKills = display.newText('', SW_VIEW_ORIGIN + 20, txtLevel.y + 20, FONT_NORMAL, 14)
    txtTime = display.newText('', SW_VIEW_ORIGIN + 20, txtKills.y + 20, FONT_NORMAL, 14)
    
    txtLevel.anchorX = 0
    txtKills.anchorX = 0
    txtTime.anchorX = 0
    
    mainGroup:insert(txtLevel)
    mainGroup:insert(txtKills)
    mainGroup:insert(txtTime)
    
    local function updateTime()
    
        handler.stats.time = handler.stats.time + 1
        txtTime.text = "Time: " .. handler.stats.time
    end
    
    local function setAll()
    
        txtLevel.text = "Level: " .. handler.stats.level
        txtKills.text = "Points: " .. handler.stats.kills
        txtTime.text = "Time: " .. handler.stats.time
    end
    
    local function updateLevel()
    
        handler.stats.level = handler.stats.level + 1
        txtLevel.text = "Level: " .. handler.stats.level
        audio.play(levelUpSound)
    end
    
    function handler:start()
    
        setAll()
        timerAlive = timer.performWithDelay(1000, updateTime, -1)
        timer.pause(timerAlive)
    end
    
    function handler:restart()
    
        handler.stats = { 
            level = 0, 
            kills = 0, 
            time = 0 
        }
        setAll()
    end
    
    function handler:resume()
    
        timer.resume(timerAlive)
    end
    
    function handler:pause()
    
        timer.pause(timerAlive)
    end
    
    function handler:updateKill()
    
        handler.stats.kills = handler.stats.kills + 1
        txtKills.text = "Kills " .. handler.stats.kills
        
        if handler.stats.kills == 1 then updateLevel()
        elseif handler.stats.kills == 2 then updateLevel()
        elseif handler.stats.kills == 3 then updateLevel()
        elseif handler.stats.kills == 4 then updateLevel()
        elseif handler.stats.kills == 200 then updateLevel()
        elseif handler.stats.kills == 250 then updateLevel()
        elseif handler.stats.kills == 300 then updateLevel()
        elseif handler.stats.kills == 350 then updateLevel()
        elseif handler.stats.kills == 400 then updateLevel()
        elseif handler.stats.kills == 450 then updateLevel()
        elseif handler.stats.kills == 500 then updateLevel()
        elseif handler.stats.kills == 550 then updateLevel()
        elseif handler.stats.kills == 600 then updateLevel()
        elseif handler.stats.kills == 650 then updateLevel()
        elseif handler.stats.kills == 700 then updateLevel()
        elseif handler.stats.kills == 750 then updateLevel()
        elseif handler.stats.kills == 800 then updateLevel()
        elseif handler.stats.kills == 850 then updateLevel()
        elseif handler.stats.kills == 900 then updateLevel()
        elseif handler.stats.kills == 950 then updateLevel()
        elseif handler.stats.kills == 1000 then updateLevel()
            
        end
    end
    
    return handler
end
return _M