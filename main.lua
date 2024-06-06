love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(0, 0, 0)

Game = require("game")

-- Libraries
Basics = require("libs/basics")
anim8 = require("libs/anim8")
bump = require("libs/bump")
Player = require("player")

Scale = 3

Mouse = love.graphics.newImage("assets/sprites/screen/cursor.png")
BG = love.graphics.newImage("assets/sprites/screen/bg.png")

function love.load()
    Basics:initGraphics({480, 432}, 'landscape', false, Scale, true)
    world = bump.newWorld(64)
    player = Player:new(world, 0, 0)

    love.mouse.setVisible(false)
end


function love.update(dt)
    player:update(dt)
end

function love.draw()
    Cam:attach()
    
		love.graphics.draw(BG, 0, 0, nil, nil, nil, BG:getWidth()/2,BG:getHeight()/2)
    	
    	player:draw()
    
    Cam:detach()

    love.graphics.draw(Mouse, love.mouse.getX(), love.mouse.getY(), nil, Scale,Scale, Mouse:getWidth()/2, Mouse:getHeight()/2)
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'escape' then -- Quit the game, for debug
        love.event.quit()
    elseif key == 'f4' then
        Basics.fullscreen()
    end
end
