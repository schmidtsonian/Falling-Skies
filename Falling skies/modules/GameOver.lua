local _M = {}


function _M:new(mainGroup)

    local handler = {}
    local title, level, kills, time, btRestart, overlay
    local selectSound = audio.loadSound( "sfx/Select.wav" )
    
    local function closeAll()
        title.x = MIDDLE_WIDTH - 1600
        level.x = MIDDLE_WIDTH - 1600
        kills.x = MIDDLE_WIDTH - 1600
        time.x = MIDDLE_WIDTH - 1600
        overlay.x = MIDDLE_WIDTH - 1600
        btRestart.x = MIDDLE_WIDTH - 1600 - 90
    end
    
    function handler:open(stats)

        title.x = MIDDLE_WIDTH
        overlay.x = MIDDLE_WIDTH
        btRestart.x = MIDDLE_WIDTH
        
        level.x = MIDDLE_WIDTH
        kills.x = MIDDLE_WIDTH
        time.x = MIDDLE_WIDTH
        
        
        level.text = "Level: " .. stats.level
        kills.text = "Points: " .. stats.kills
        time.text = "Time: " .. stats.time
    end
    
    function handler:close()
    
        closeAll()
    end
    
    function handler:restart()
        
        closeAll()
        handler.onRestart()
        audio.play(selectSound)
    end
    
    overlay = display.newRoundedRect(mainGroup, MIDDLE_WIDTH-1600, MIDDLE_HEIGHT, display.actualContentWidth, display.actualContentHeight, 0)
    overlay:setFillColor(0)
    overlay.alpha = .9
    
    title = display.newText("FINAL SCORE", MIDDLE_WIDTH - 1600, MIDDLE_HEIGHT - 100, FONT_BOLD, 18)
    level = display.newText("Level: " .. 0, MIDDLE_WIDTH - 1600, title.y + 30, FONT_BOLD, 24)
    kills = display.newText("Kills: " .. 0, MIDDLE_WIDTH - 1600, level.y + 30, FONT_BOLD, 24)
    time = display.newText("Time: " .. 0, MIDDLE_WIDTH - 1600, kills.y + 30, FONT_BOLD, 24)
    btRestart = Widget.newButton( {
        left = MIDDLE_WIDTH - 1600,
        top = MIDDLE_HEIGHT + 50,
        id = "btRestartGO",
        label = "Re",
        emboss = false,
        shape = "roundedRect",
        width = 60,
        height = 60,
        cornerRadius = 0,
        fillColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
        onEvent = handler.restart
    } )
    
    mainGroup:insert(title)
    mainGroup:insert(level)
    mainGroup:insert(kills)
    mainGroup:insert(time)
    mainGroup:insert(btRestart)
    
    
    return handler
end
return _M