love.graphics.setDefaultFilter("nearest","nearest")
love.graphics.setBackgroundColor(0,.3,.3)

Game = require("game")

-- Libraries
Basics = require("libs/basics")

function love.load()
	Basics:initGraphics({640,480},'landscape',false,3,false)
end

function love.update(dt)
end

function love.draw()
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then -- Quit the game, for debug
		love.event.quit()
	elseif key == 'f4' then
		Basics.fullscreen()
	end
end