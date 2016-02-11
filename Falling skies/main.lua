display.setStatusBar( display.HiddenStatusBar )



-- Libraries
require "lib.Common"

-- Objects
-- easingx = require "lib.Easing"
-- tnt = require "class.Transitions"

local composer = require "composer"
Physics = require "physics"
Widget = require "widget"

Hud = require "scenes.Hud"

Physics.start()
Physics.setGravity( 0, 0 )

-- Initialice
local options = {
    effect = "fade",
    time = 800,
}


local function garbagePrinting()
	collectgarbage("collect")
    local memUsage_str = string.format( "memUsage = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str )
    local texMemUsage_str = system.getInfo( "textureMemoryUsed" )
    texMemUsage_str = texMemUsage_str/1000
    texMemUsage_str = string.format( "texMemUsage = %.3f MB", texMemUsage_str )
    print( texMemUsage_str )
end

Runtime:addEventListener( "enterFrame", garbagePrinting )
composer.gotoScene("scenes.Hud", options) 