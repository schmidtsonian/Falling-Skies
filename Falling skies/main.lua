display.setStatusBar( display.HiddenStatusBar )

physics.start()
physics.setGravity( 0, 0 )

-- Libraries
require "lib.Common"

-- Objects
easingx = require "lib.Easing"
tnt = require "class.Transitions"
physics = require "physics"
hud = require "hud"

-- Initialice
hud:new()