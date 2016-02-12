local _M = {}


function _M:new(mainGroup)

    local handler = {}
    local title, level, kills, bullets, btRestart, overlay
    
    function handler:open()
    end
    
    function handler:close()
    end
    
    function handler:restart()
        
        handler.onRestart()
    end
    
    overlay = display.newRoundedRect(mainGroup, display.actualContentWidth*-1 - 1600, MIDDLE_HEIGHT, display.actualContentWidth, display.actualContentHeight, 0)
    title = display.newText("GAME OVER", MIDDLE_WIDTH - 1600, MIDDLE_HEIGHT - 100, FONT_BOLD, 32)
    level = display.newText("Level: " .. 0, MIDDLE_WIDTH - 1600, MIDDLE_HEIGHT - 50, FONT_BOLD, 24)
    kills = display.newText("Kills: " .. 0, MIDDLE_WIDTH - 1600, level.y + 30, FONT_BOLD, 24)
    bullets = display.newText("Bullets: " .. 0, MIDDLE_WIDTH - 1600, kills.y + 30, FONT_BOLD, 24)
    btRestart = Widget.newButton( {
        left = MIDDLE_WIDTH - 90 - 1600,
        top = MIDDLE_HEIGHT + 50,
        id = "btRestartGO",
        label = "Re",
        emboss = false,
        shape = "roundedRect",
        width = 60,
        height = 60,
        cornerRadius = 0,
        fillColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
        onEvent = handler.onRestart
    } )
    overlay:setFillColor(0)
    overlay.alpha = .5
    
    mainGroup:insert(title)
    mainGroup:insert(level)
    mainGroup:insert(kills)
    mainGroup:insert(bullets)
    mainGroup:insert(btRestart)
    
    
    return handler
end
return _M