local _M = {}

function _M:new(mainGroup)

    local handler = {}
    
    local countText, overlay 
    
    overlay = display.newRoundedRect(MIDDLE_WIDTH -1600, MIDDLE_HEIGHT, display.actualContentWidth, display.actualContentHeight, 0)
    overlay:setFillColor(0)
    overlay.alpha = .3
   
    countText = display.newText(3, MIDDLE_WIDTH - 1600, MIDDLE_HEIGHT, FONT_BOLD, 28)
    
    mainGroup:insert(overlay)
    mainGroup:insert(countText)
    
    function handler:start(onComplete)
        
        local function setTime(e)
            if e.count == 3 then 
                overlay.x = MIDDLE_WIDTH - 1600
                countText.x = MIDDLE_WIDTH - 1600
                countText.text = 3
                onComplete()
            else
                countText.text = (e.count*-1) + 3
            end
        end
        
        overlay.x = MIDDLE_WIDTH
        countText.x = MIDDLE_WIDTH
        timer.performWithDelay( 1000, setTime, 3)
    end
    
    
    
    return handler
end

return _M