local _M = {}

function _M:new(mainGroup)

    local handler = {}
    handler.onComplete = function() end
    
    local count, countText, overlay 
    
    count = 3;
    
    overlay = display.newRoundedRect(MIDDLE_WIDTH -1600, MIDDLE_HEIGHT, display.actualContentWidth, display.actualContentHeight, 0)
    overlay:setFillColor(0)
    overlay.alpha = .9
   
    countText = display.newText(count, MIDDLE_WIDTH - 1600, MIDDLE_HEIGHT, FONT_BOLD, 28)
    
    mainGroup:insert(overlay)
    mainGroup:insert(countText)
    
    
    local function close()
    
        print("CLOSE!!!")
        overlay.x = MIDDLE_WIDTH - 1600
        countText.x = MIDDLE_WIDTH - 1600
        countText.text = 3
        handler.onComplete()
    end
    
    local function setTime()
        count = count - 1;
        
        if count == 0 then 
            close()
        else
            countText.text = count
        end
        
        
    end
    
    function handler:start()
        
        count = 3;
        
        overlay.x = MIDDLE_WIDTH
        countText.x = MIDDLE_WIDTH
        timer.performWithDelay( 1000, setTime, 4)
    end
    
    
    
    return handler
end

return _M