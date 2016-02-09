local _M = {}

function _M:new()

    local handler = {}
    handler.isPause = true;
    handler.bt = Widget.newButton( {
        left = SW_VIEW - 25,
        top = SH_VIEW_ORIGIN + 25,
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
    
    function handler:open()
        print("pause open")
    end
    
    function handler:close()
        print("pause close")
    end
    
    return handler
end

return _M