local _M = {}


function _M:new(mainGroup)

    local handler = {}
    local title, level, kills, bullets, btRestart, overlay
    
    local function closeAll()
        title.x = MIDDLE_WIDTH - 1600
        level.x = MIDDLE_WIDTH - 1600
        kills.x = MIDDLE_WIDTH - 1600
        bullets.x = MIDDLE_WIDTH - 1600
        overlay.x = MIDDLE_WIDTH - 1600
        btRestart.x = MIDDLE_WIDTH - 1600 - 90
    end
    
    function handler:open()

        title.x = MIDDLE_WIDTH
        level.x = MIDDLE_WIDTH
        kills.x = MIDDLE_WIDTH
        bullets.x = MIDDLE_WIDTH
        overlay.x = MIDDLE_WIDTH
        btRestart.x = MIDDLE_WIDTH
    end
    
    function handler:close()
    
        closeAll()
    end
    
    function handler:restart()
        
        closeAll()
        handler.onRestart()
    end
    
    overlay = display.newRoundedRect(mainGroup, MIDDLE_WIDTH-1600, MIDDLE_HEIGHT, display.actualContentWidth, display.actualContentHeight, 0)
    overlay:setFillColor(0)
    overlay.alpha = .9
    
    title = display.newText("GAME OVER", MIDDLE_WIDTH - 1600, MIDDLE_HEIGHT - 100, FONT_BOLD, 32)
    level = display.newText("Level: " .. 0, MIDDLE_WIDTH - 1600, MIDDLE_HEIGHT - 50, FONT_BOLD, 24)
    kills = display.newText("Kills: " .. 0, MIDDLE_WIDTH - 1600, level.y + 30, FONT_BOLD, 24)
    bullets = display.newText("Bullets: " .. 0, MIDDLE_WIDTH - 1600, kills.y + 30, FONT_BOLD, 24)
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
    mainGroup:insert(bullets)
    mainGroup:insert(btRestart)
    
    
    return handler
end
return _M