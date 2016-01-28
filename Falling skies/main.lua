display.setStatusBar( display.HiddenStatusBar )



-- Libraries
require "lib.Common"

-- Objects
easingx = require "lib.Easing"
tnt = require "class.Transitions"
physics = require "physics"
hud = require "hud"

physics.start()
physics.setGravity( 0, 0 )

-- Initialice
hud:new()