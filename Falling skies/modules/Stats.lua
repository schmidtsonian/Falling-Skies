local _M = {}

function _M:new(mainGroup)

    local handler = {}
    local txtLevel, txtKills, txtTime
    local timerAlive
    local stats = { 
        level = 0, 
        kills = 0, 
        time = 0 
    }
    
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
    
        stats.time = stats.time + 0.00001
        txtTime.text = "Time " .. stats.time
    end
    
    local function setAll()
    
        txtLevel.text = "Level: " .. stats.level
        txtKills.text = "Kills: " .. stats.kills
        txtTime.text = "Time: " .. stats.time
    end
    
    local function updateLevel()
    
        stats.level = stats.level + 1
        txtLevel.text = "Level " .. stats.level
    end
    
    function handler:start()
    
        setAll()
        timerAlive = timer.performWithDelay(10, updateTime, -1)
        timer.pause(timerAlive)
    end
    
    function handler:restart()
    
        stats = { 
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
    
    function handler:getStats()
        return stats
    end
    
    function handler:updateKill()
    
        stats.kills = stats.kills + 1
        txtKills.text = "Kills " .. stats.kills
        
        if stats.kills == 10 then updateLevel()
        elseif stats.kills == 50 then updateLevel()
        elseif stats.kills == 100 then updateLevel()
        elseif stats.kills == 150 then updateLevel()
        elseif stats.kills == 200 then updateLevel()
        elseif stats.kills == 250 then updateLevel()
        elseif stats.kills == 300 then updateLevel()
        elseif stats.kills == 350 then updateLevel()
        elseif stats.kills == 400 then updateLevel()
        elseif stats.kills == 450 then updateLevel()
        elseif stats.kills == 500 then updateLevel()
        elseif stats.kills == 550 then updateLevel()
        elseif stats.kills == 600 then updateLevel()
        elseif stats.kills == 650 then updateLevel()
        elseif stats.kills == 700 then updateLevel()
        elseif stats.kills == 750 then updateLevel()
        elseif stats.kills == 800 then updateLevel()
        elseif stats.kills == 850 then updateLevel()
        elseif stats.kills == 900 then updateLevel()
        elseif stats.kills == 950 then updateLevel()
        elseif stats.kills == 1000 then updateLevel()
            
        end
    end
    
    return handler
end
return _M