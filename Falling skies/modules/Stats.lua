local _M = {}

function _M:new(mainGroup)

    local handler = {}
    local txtLevel, txtKills, txtTime, txtWeapon
    local timerAlive
    handler.stats = { 
        level = 0, 
        kills = 0, 
        time = 0,
        weapon = 1, 
    }
    local levelUpSound = audio.loadSound( "sfx/Level_Up.wav" )
    
    txtLevel = display.newText('', SW_VIEW_ORIGIN + 20, SH_VIEW_ORIGIN + 30, FONT_NORMAL, 14)
    txtKills = display.newText('', SW_VIEW_ORIGIN + 20, txtLevel.y + 20, FONT_NORMAL, 14)
    txtTime = display.newText('', SW_VIEW_ORIGIN + 20, txtKills.y + 20, FONT_NORMAL, 14)
    txtWeapon = display.newText('', SW_VIEW_ORIGIN + 20, txtTime.y + 20, FONT_NORMAL, 14)
    
    txtLevel.anchorX = 0
    txtKills.anchorX = 0
    txtTime.anchorX = 0
    txtWeapon.anchorX = 0
    
    mainGroup:insert(txtLevel)
    mainGroup:insert(txtKills)
    mainGroup:insert(txtTime)
    mainGroup:insert(txtWeapon)
    
    local function updateTime()
    
        handler.stats.time = handler.stats.time + 1
        txtTime.text = "Time: " .. handler.stats.time
    end
    
    local function setAll()
    
        txtLevel.text = "Level: " .. handler.stats.level
        txtKills.text = "Points: " .. handler.stats.kills
        txtTime.text = "Time: " .. handler.stats.time
        txtWeapon.text = "Weapon: " .. handler.stats.weapon
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
            time = 0,
            weapon = 1; 
        }
        setAll()
    end
    
    function handler:resume()
    
        timer.resume(timerAlive)
    end
    
    function handler:pause()
    
        timer.pause(timerAlive)
    end
    
    function handler:updateWeapon()
        
        handler.stats.weapon = handler.stats.weapon + 1
        txtWeapon.text = "Weapon: " .. handler.stats.weapon
    end
    
    function handler:updateKill()
    
        handler.stats.kills = handler.stats.kills + 1
        txtKills.text = "Kills " .. handler.stats.kills
        
        if handler.stats.kills == 5 then updateLevel()
        elseif handler.stats.kills == 10 then updateLevel()
        elseif handler.stats.kills == 20 then updateLevel()
        elseif handler.stats.kills == 30 then updateLevel()
        elseif handler.stats.kills == 40 then updateLevel()
        elseif handler.stats.kills == 80 then updateLevel()
        elseif handler.stats.kills == 100 then updateLevel()
        elseif handler.stats.kills == 150 then updateLevel()
        elseif handler.stats.kills == 250 then updateLevel()
        elseif handler.stats.kills == 350 then updateLevel()
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