display.setStatusBar( display.HiddenStatusBar )



-- Libraries
require "lib.Common"

-- Objects
easingx = require "lib.Easing"
-- tnt = require "class.Transitions"
Physics = require "physics"
Hud = require "Hud"

Physics.start()
Physics.setGravity( 0, 0 )

-- Initialice
Hud:new()