love.graphics.setDefaultFilter("nearest","nearest")
love.graphics.setBackgroundColor(0,.3,.3)

Game = require("game")

-- Libraries
Basics = require("libs/basics")

function love.load()
	Basics:initGraphics({480,432},'landscape',false,3,true)
end

function love.update(dt)
end

function love.draw()
	Cam:attach()
		-- Graphics go here to scale it
	Cam:detach()
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then -- Quit the game, for debug
		love.event.quit()
	elseif key == 'f4' then
		Basics.fullscreen()
	end
end