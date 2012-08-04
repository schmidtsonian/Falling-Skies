--[[
	Original Filename: Hud.lua
    Project: Galaxyar 
    Version: 1.0
    Copyright: Fugitive Pixel Studios 2012
    Description: Vista para Heads Up Display
]]--

local scene = storyboard.newScene()

local ui
local tChunks

local _onTouchBg, _onFrameShip, _onCollision, _startGame,
_createShip, _createGameProgress, _createGameMenu, _createChunks


_createChunks = function()

	local g = display.newGroup()
	local buss = { src = "", w = 150, h = 80, name = "enemy" }
	local ligth = { src = "", w = 10, h = 100, name = "enemy" }
	local aireplane = { src = "", w = 70, h = 20, name = "enemy" }

	local prole = { src = "", w = 20, h = 50, name = "coin" }
	local paparazzi = { src = "", w = 30, h = 50, name = "coin" }                                               

	g.chunks = {
		[ 1 ] = {
			[ 1 ] = { { data = buss,			y = SH_VIEW - 10 } },
			[ 2 ] = { { data = ligth,			y = SH_VIEW - 10 } },
			[ 3 ] = { { data = aireplane,		y = math.random( 80, BG_SW - 10 ) } },
			[ 4 ] = { { data = prole,			y = SH_VIEW - 10 } },
			[ 5 ] = { { data = paparazzi,		y = SH_VIEW - 10 } },
		},
		[ 2 ] = {
			[ 1 ] = { { data = buss,			y = SH_VIEW - 10 }, { data = aireplane, y = math.random( 80, MIDDLE_HEIGHT ) } },
			[ 2 ] = { { data = ligth,			y = SH_VIEW - 10 }, { data = aireplane, y = math.random( 80, MIDDLE_HEIGHT ) } },
			[ 3 ] = { { data = aireplane,		y = math.random( 80, BG_SW - 10 ) } },
			[ 4 ] = { { data = prole,			y = SH_VIEW - 10 }, { data = aireplane, y = math.random( 80, MIDDLE_HEIGHT ) } },
			[ 5 ] = { { data = paparazzi,		y = SH_VIEW - 10} },
		},
		[ 3 ] = {

		},
	}

	g.level = 2
	g.velocity = 8000

	function g:dispatch()

		local chunk = self.chunks[ self.level ][ math.random( 1, 5 ) ]
		for _, object in ipairs( chunk ) do
			--local object = self.chunks[ self.level ][ math.random( 1, 5 ) ]
			-- local item = display.newImageRect( self, object.data.src, object.data.w, object.data.h )
			local item = display.newRect( self, 0, 0, object.data.w, object.data.h )
			item:setReferencePoint( display.BottomCenterReferencePoint )
			-- item:setFillColor()
			item.x = BG_SW + 100
			item.y = object.y
			item.name = object.data.name
			print( item.name, item.x, object.y)
			physics.addBody( item, { density = 3.0, friction = 0.5, bounce = 0.3 } )
			
			item.time = nil
			item.time = tnt:newTransition( item, { time = self.velocity, x = -100, onComplete = 
				function()
					item:removeSelf()
				end } )
		end
	end

	return g
end

_createShip = function ()

	local g = display.newGroup()
	-- g.gMotor = display.newGroup()
		
	-- setup ship
	g.body = display.newRect( g, 0, 0, 20, 10 )
	g.propulsors = display.newRect( g, 0, 0, 20, 30 )
	g.propulsors.x = g.body.x - 5
	g.propulsors.y = g.body.y + 5

	physics.addBody( g, "static", { density = 3.0, friction = 0.5, bounce = 0.3 } )

	g.isMoving = false

	g.isUp = false
	g.isDown = true

	g.yLimitMax = 50
	g.yLimitMin = BG_SH - 80

	g.gravity = 1 --// 1, 2, 3
	g.gravityUp = 6
	g.gravityDown = 5

	function g:setGravity( gravity )
		self.gravity = gravity or 1
		if self.gravity == 1 then
			self.gravityUp = 6
			self.gravityDown = 5
		elseif g.gravity == 2 then
			self.gravityUp = 8
			self.gravityDown = 3
		elseif g.gravity == 3 then
			self.gravityUp = 9
			self.gravityDown = 2
		end
	end 

	function g:move( e )
		if e.phase == "began" and self.isUp then
			self.isMoving = true
			self.isUp = false
			self.isDown = true
		elseif e.phase == "began" and self.isDown then
			self.isMoving = true
			self.isUp = true
			self.isDown = false
		elseif e.phase == "ended" then
			self.isMoving = false
		end
	end

	function g:onFrame( e )

		if self.isMoving and self.isUp and self.y > g.yLimitMax then 
			self.y = self.y - g.gravityUp
		elseif self.isMoving and self.isDown and self.y < g.yLimitMin then
			self.y = self.y + g.gravityDown
		end
	end

	function g:destroy()
	end

	return g
end

_createGameProgress = function()
	local g = display.newGroup()

	g.gScore = display.newGroup()
	g.gLives = display.newGroup()

	g:insert( g.gScore )
	g:insert( g.gLives )

	g.score = 0
	g.lives = 4

	g.txtScore = display.newText( g.gScore, "Score:", 0, 0, FONT_1, 18 )
	g.txtScore:setReferencePoint( display.CenterRightReferencePoint )
	g.txtScore.x = SW_VIEW - 200
	g.txtScore.y = SH_VIEW_ORIGIN + 30

	g.txtScore.points = display.newText( g.gScore, "", 0, 0, FONT_1, 18 )
	g.txtScore.points.y = g.txtScore.y

	g.ship = display.newRect( g.gLives, 0, 0, 15, 15 )
	g.ship:setReferencePoint( display.CenterLeftReferencePoint )
	g.ship.x = SW_VIEW_ORIGIN + 30
	g.ship.y = g.txtScore.y 
	g.ship:setReferencePoint( display.CenterRightReferencePoint )

	g.txtLives = display.newText( g.gLives, "", 0, 0, FONT_1, 18 )
	g.txtLives.y = g.txtScore.y

	function g:setScore( points )

		g.score = g.score + points

		g.txtScore.points:setReferencePoint( display.CenterLeftReferencePoint )
		g.txtScore.points.x = g.txtScore.x + 10
		g.txtScore.points.text = "" .. g.score

		g.gScore.x = 3
		g.gScore.y = 3
		tnt:newTransition( g.gScore, { x = 0, y = 0, time = 100, transition = easingx.easeOutInElastic } )
	end

	function g:reloadLives()

		g.lives = g.lives - 1
		g.txtLives.text = "X " .. g.lives
		g.txtLives:setReferencePoint( display.CenterLeftReferencePoint )
		g.txtLives.x = g.ship.x + 10

		g.gLives.x = 3
		g.gLives.y = 3
		tnt:newTransition( g.gLives, { x = 0, y = 0, time = 100, transition = easingx.easeOutInElastic } )

		return g.lives == 0
	end

	return g
end

_createGameMenu = function()
	local g = display.newGroup()

	g.gBtPause = display.newGroup()
	g.gMenu = display.newGroup()

	g.isPaused = false

	g:insert( g.gBtPause )
	g:insert( g.gMenu )

	-- Settings Bt Pause
	g.gBtPause.bg = display.newRect( g.gBtPause, 0, 0, 40, 40 )
	g.gBtPause.bg.alpha = .3

	g.gBtPause.btP1 = display.newRect( g.gBtPause, 0, 0, 5, 15 )
	g.gBtPause.btP2 = display.newRect( g.gBtPause, 0, 0, 5, 15 )
	
	g.gBtPause.bg:setReferencePoint( display.CenterRightReferencePoint )
	g.gBtPause.bg.x = SW_VIEW - 30
	g.gBtPause.bg.y = SH_VIEW_ORIGIN + 30
	g.gBtPause.bg:setReferencePoint( display.CenterReferencePoint )

	g.gBtPause.btP1.x = g.gBtPause.bg.x - 5
	g.gBtPause.btP1.y = g.gBtPause.bg.y
	
	g.gBtPause.btP2.x = g.gBtPause.bg.x + 5
	g.gBtPause.btP2.y = g.gBtPause.bg.y

	g.gBtPause.bgBlock = display.newRect( g.gBtPause, 0, 0, BG_SW, BG_SH )
	g.gBtPause.bgBlock:setFillColor( 0, 0, 0 )
	g.gBtPause.bgBlock.alpha = 0
	g.gBtPause.bgBlock.x = MIDDLE_WIDTH
	g.gBtPause.bgBlock.y = MIDDLE_HEIGHT

	-- Settings Bt Menu Pause
	g.gMenu.alpha = 0

	g.gMenu.bg = display.newRect( g.gMenu, 0, 0, 450, 220 )
	g.gMenu.bg.x = MIDDLE_WIDTH
	g.gMenu.bg.y = MIDDLE_HEIGHT

	g.gMenu.btMenu = _createBt( g.gMenu, "Menu", 130 )
	g.gMenu.btMenu.x = g.gMenu.bg.x - 145
	g.gMenu.btMenu.y = g.gMenu.bg.y

	g.gMenu.btRestart = _createBt( g.gMenu, "Restart", 130 )
	g.gMenu.btRestart.x = g.gMenu.bg.x
	g.gMenu.btRestart.y = g.gMenu.bg.y
	
	g.gMenu.btContinue = _createBt( g.gMenu, "Continue", 130 )
	g.gMenu.btContinue.x = g.gMenu.bg.x + 145
	g.gMenu.btContinue.y = g.gMenu.bg.y

	function g:showMenu( score )
		tnt:pauseAllTimers()
		tnt:pauseAllTransitions()
		g.isPaused = true
		-- physics.stop()

		g.gBtPause.bgBlock.alpha = .7
		g.gMenu.alpha = 1

		g.gMenu.x = SW_VIEW
		g.gMenu.y = SH_VIEW + 100

		local _hideBt = function( bt )
			bt.alpha = 0
			bt.xScale = .1
			bt.yScale = .1
		end

		_hideBt( g.gMenu.btMenu )
		_hideBt( g.gMenu.btRestart )
		_hideBt( g.gMenu.btContinue )

		tnt:newTransition( g.gMenu, { x = 0, y = 0, time = 500, onComplete = 
			function() 
				--Show Buttons
				tnt:newTransition( g.gMenu.btMenu, { alpha = 1, xScale = 1, yScale = 1, time = 150, delay = 180 } )
				tnt:newTransition( g.gMenu.btRestart, { alpha = 1, xScale = 1, yScale = 1, time = 150, delay = 260 } )
				tnt:newTransition( g.gMenu.btContinue, { alpha = 1, xScale = 1, yScale = 1, time = 150, delay = 340 } )
			end } )
	end

	local _hideMenu = function()

		tnt:newTransition( g.gMenu, { alpha = 0, time = 500, onComplete = 
			function()
				g.gBtPause.bgBlock.alpha = 0

				tnt:resumeAllTransitions()
				tnt:resumeAllTimers()
				g.isPaused = false
				-- physics.start()
			end } )
	end

	local _onBtMenu = function( e )
		if e.phase == "began" then
			e.target.action()
		end
	end

	-- Setting listeners
	g.gBtPause.action = function() if g.isPaused == false then g:showMenu() end end
	g.gMenu.btRestart.action = function() storyboard.gotoScene( "scenes.Restart", "fade", TIME_CHANGE_SCENE ) end
	g.gMenu.btMenu.action = function() storyboard.gotoScene( "scenes.Menu", "fade", TIME_CHANGE_SCENE ) end
	g.gMenu.btContinue.action = function() _hideMenu() end

	g.gBtPause:addEventListener( "touch", _onBtMenu )
	g.gMenu.btMenu:addEventListener( "touch", _onBtMenu )
	g.gMenu.btRestart:addEventListener( "touch", _onBtMenu )
	g.gMenu.btContinue:addEventListener( "touch", _onBtMenu )
	
	return g
end

_onTouchBg = function( e )
	if ui.gGameMenu.isPaused then return end
	ui.gShip:move( e )
end

_onFrameShip = function( e )
	if ui.gGameMenu.isPaused then return end
	ui.gShip:onFrame( e )
end

_onCollision = function( event )
	if ( event.phase == "began" ) then

		local object1, object2
		if event.object1.name == "coin" and event.object2.name == "ship" then
			object1 = event.object1
		elseif event.object2.name == "coin" and event.object1.name == "ship" then
			object1 = event.object2
		
		elseif event.object1.name == "enemy" and event.object2.name == "ship" then
			object2 = event.object1
		elseif event.object2.name == "enemy" and event.object1.name == "ship" then
			object2 = event.object2
		end

		-- Delete Coin
		if object1 then
			object1.time:cancel()
			object1.time = nil
			object1:removeSelf()
			object1 = nil
			ui.gGameProgress:setScore( 1 )
			
		elseif object2 then
			object2.time:cancel()
			object2.time = nil
			object2:removeSelf()
			object2 = nil

			ui.g.time:cancel()
			ui.g.time = nil
			
			_startGame()

			local isDead = ui.gGameProgress:reloadLives()
			if isDead then ui.gGameMenu:showMenu( 0 ) end
		end
	else
		-- print( event.phase )
	end
end

_startGame = function()

	if ui.gShip.timeDown then 
		ui.gShip.timeDown:cancel()
		ui.gShip.timeDown = nil
	end

	if ui.gShip.timeUp then
		ui.gShip.timeUp:cancel()
		ui.gShip.timeUp = nil
	end

	ui.gGameMenu.isPaused = true
	ui.gShip.name = "none"

	ui.gShip.alpha = 0
	tnt:newTimer( 500, 
		function() 
			ui.gShip.y = -100
			ui.gShip.alpha = 1
			tnt:newTransition( ui.gShip, { time = 3000, y = ui.gShip.yLimitMin, delay = 1000, onComplete = 
				function()
					ui.gShip.name = "ship"
					ui.g.time = tnt:newTimer( 2000, function() ui.gChunks:dispatch() end, 0 )
					ui.gGameMenu.isPaused = false
					ui.gGameMenu:toFront()
				end } )
		end, 1 )
end

function scene:createScene( e )
	print("--Create scene: HUD")
	ui = {}
	tChunks = {}

	ui.g = self.view

	ui.bg = display.newRect( ui.g, 0, 0, BG_SW, BG_SH )
	ui.bg:setFillColor( 0, 0, 0 )
	ui.bg.x = MIDDLE_WIDTH
	ui.bg.y = MIDDLE_HEIGHT

	ui.gGameProgress = _createGameProgress()
	
	ui.gGameMenu = _createGameMenu()

	-- setup ship
	ui.gShip = _createShip()
	ui.gShip.x = ui.gShip.width + 20
	ui.gShip.y = -100

	-- setup enemies
	--ui.gEnemy = _createEnemies()

	-- setup coins
	--ui.gCoins = _createCoins()

	-- setup chunks
	ui.gChunks = _createChunks()

	ui.g:insert( ui.bg )
	ui.g:insert( ui.gGameProgress )
	ui.g:insert( ui.gShip )
	ui.g:insert( ui.gChunks )
	-- ui.g:insert( ui.gCoins )
	-- ui.g:insert( ui.gEnemy )
	ui.g:insert( ui.gGameMenu )
end

function scene:enterScene( e )
	print("--Enter scene: HUD")

	ui.gGameProgress:setScore( 0 )
	ui.gGameProgress:reloadLives()

	ui.g:addEventListener( "touch", _onTouchBg )

	ui.gShip:setGravity( 1 )
	ui.gShip.name = "ship"
	Runtime:addEventListener( "enterFrame", _onFrameShip )

	Runtime:addEventListener( "collision", _onCollision )
	
	_startGame()	
end

function scene:exitScene( e )
	print("--Exit scene: HUD")
	_cleanTransitions()
	storyboard.purgeAll()
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )

return scene