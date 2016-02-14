local _M = {}

function _M:new(mainGroup)

    local handler = {}
    handler.isPause = false
    handler.onPause = function() end
    handler.onResume = function() end
    handler.onRestart = function() end
    
    local btRestart, btResume, barCenter, bar1, bar2, bar3, bar4
    
    local function closeAll()

        handler.bt.x = SW_VIEW - 35
        
        overlay.x = display.actualContentWidth * -1
        barCenter.x = MIDDLE_WIDTH -1600
        bar1.x = MIDDLE_WIDTH + 1680 
        bar2.x = MIDDLE_WIDTH - 1650 
        bar3.x = MIDDLE_WIDTH - 1750 
        bar4.x = MIDDLE_WIDTH + 1720 
        
        
        btResume.x = 1600 - MIDDLE_WIDTH - 90
        btRestart.x = 1600 - MIDDLE_WIDTH
        
        handler.isPause = false;
    end
    
    function handler:close()
        
        closeAll()
        handler.onResume()
    end
    
    function handler:restart()
    
        closeAll()
        handler.onRestart()
    end
    
    function handler:open()

        if handler.isPause == true then return end
        
        handler.onPause()
        handler.isPause = true;
        
        handler.bt.x = SW_VIEW - 1600
        
        overlay.x = MIDDLE_WIDTH
        barCenter.x = MIDDLE_WIDTH
        bar1.x = MIDDLE_WIDTH + 80 
        bar2.x = MIDDLE_WIDTH - 50 
        bar3.x = MIDDLE_WIDTH - 150 
        bar4.x = MIDDLE_WIDTH + 120 
        
        btResume.x = MIDDLE_WIDTH - 50
        btRestart.x = MIDDLE_WIDTH + 50
    end
    
    function handler:lock()
        handler.isPause = true;
    end
    
    function handler:unlock()
        handler.isPause = false;
    end
    
    overlay = display.newRoundedRect(mainGroup, display.actualContentWidth*-1, MIDDLE_HEIGHT, display.actualContentWidth, display.actualContentHeight, 0)
    overlay:setFillColor(0)
    overlay.alpha = .5
    
    barCenter = display.newRoundedRect(mainGroup, 1600 - MIDDLE_WIDTH, MIDDLE_HEIGHT, display.actualContentWidth, 100, 0)
    
    bar1 = display.newRoundedRect(mainGroup, 1600 + MIDDLE_WIDTH + 80, MIDDLE_HEIGHT - 120, display.actualContentWidth, 20, 0)
    bar2 = display.newRoundedRect(mainGroup, 1600 - MIDDLE_WIDTH - 50, MIDDLE_HEIGHT - 80, display.actualContentWidth, 20, 0)
    
    bar3 = display.newRoundedRect(mainGroup, 1600 - MIDDLE_WIDTH - 150, MIDDLE_HEIGHT + 80, display.actualContentWidth, 20, 0)
    bar4 = display.newRoundedRect(mainGroup, 1600 + MIDDLE_WIDTH + 120, MIDDLE_HEIGHT + 120, display.actualContentWidth, 20, 0)
    
    handler.bt = Widget.newButton( {
        left = SW_VIEW - 50,
        top = SH_VIEW_ORIGIN + 50,
        id = "btPause",
        label = "|| ||",
        emboss = false,
        shape = "roundedRect",
        width = 30,
        height = 30,
        cornerRadius = 0,
        fillColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
        onEvent = handler.open
    } )
    
    btResume = Widget.newButton( {
        left = 1600 - MIDDLE_WIDTH - 130,
        top = MIDDLE_HEIGHT - 30,
        id = "btResume",
        label = "R",
        emboss = false,
        shape = "roundedRect",
        width = 60,
        height = 60,
        cornerRadius = 0,
        fillColor = { default={0,0,0,1}, over={1,1,1,1} },
        onEvent = handler.close
    } )
    
    btRestart = Widget.newButton( {
        left = 1600 - MIDDLE_WIDTH - 30,
        top = MIDDLE_HEIGHT - 30,
        id = "btRestart",
        label = "Re",
        emboss = false,
        shape = "roundedRect",
        width = 60,
        height = 60,
        cornerRadius = 0,
        fillColor = { default={0,0,0,1}, over={1,1,1,1} },
        onEvent = handler.restart
    } )
    
    mainGroup:insert(handler.bt)
    mainGroup:insert(btResume)
    mainGroup:insert(btRestart)
    
    
    return handler
end

return _M