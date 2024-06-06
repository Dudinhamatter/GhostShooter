love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(0, .3, .3)

Game = require("game")

-- Libraries
Basics = require("libs/basics")
anim8 = require("libs/anim8")
bump = require("libs/bump")
Player = require("player")

Scale = 3

function love.load()
    Basics:initGraphics({480, 432}, 'landscape', false, Scale, true)
    world = bump.newWorld(64)
    player = Player:new(world, 0, 0)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    Cam:attach()
    player:draw()
    Cam:detach()
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'escape' then -- Quit the game, for debug
        love.event.quit()
    elseif key == 'f4' then
        Basics.fullscreen()
    end
end
