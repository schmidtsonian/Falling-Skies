local _M = {}

function _M:new(mainGroup, handleButtonEvent)

    local handler = {}
    handler.isPause = true
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
        onEvent = handleButtonEvent
    } )
    mainGroup:insert(handler.bt)
    
    local overlay = display.newRoundedRect(mainGroup, display.actualContentWidth*-1, MIDDLE_HEIGHT, display.actualContentWidth, display.actualContentHeight, 0)
    overlay:setFillColor(1, 1, 1)
    overlay.alpha = .5
    
    function handler:open()
        print("pause open")
        overlay.x = MIDDLE_WIDTH
    end
    
    function handler:close()
        print("pause close")
        overlay.x = display.actualContentWidth * -1
    end
    
    return handler
end

return _M