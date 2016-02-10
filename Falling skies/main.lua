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
-- Hud:new()
composer.gotoScene("scenes.Hud", fade, 400) 