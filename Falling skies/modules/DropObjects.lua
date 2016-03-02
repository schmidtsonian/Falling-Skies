local _M = {}

function _M:new(mainGroup)

    local handler = {}
    handler.objectReach = SH_VIEW + 50
    handler.isPaused = false
    
    local objects = {}
    
    function handler:drop(type, x, y)
    
        
        if type == "gun" then
        
            timer.performWithDelay( 50, function() 
                local obj = display.newRect(x, y, 20, 20)
                mainGroup:insert(1, obj)
                Physics.addBody(obj, "dynamic", {isSensor = true, density=2.0} )
                obj:applyForce(math.random(-20, 20), -28, obj.x, obj.y)
                obj.name = 'gun'
                obj.anchorX = 1

                obj.trans = transition.to( obj, { delay=250, rotation = math.random(-45, 45), transition=easing.inSine, time = math.random(700, 2000), y = handler.objectReach,
                    onStart =
                            function()
                                
                            end ,
                    onCancel =
                            function()
                                obj:removeSelf()
                                obj = nil
                            end ,
                    onComplete =
                            function()
                                obj:removeSelf()
                                obj = nil
                            end
                        })    
                objects[#objects+1] = obj
            
            end )
        end
        
    end
    
    function handler:pause()
        
        handler.isPaused = true 
        
        for i,obj in pairs(objects) do
            transition.pause(obj.trans)
        end
    end
    
    function handler:resume()

        for i,obj in pairs(objects) do
            transition.resume(obj.trans)
        end
        handler.isPaused = false
    end
    
    function handler:restart()

        for i,obj in pairs(objects) do
            transition.cancel(obj.trans)
        end
        handler.isPaused = false
    end
    
    return handler
end
return _M