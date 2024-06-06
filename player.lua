-- Required libraries
local anim8 = require 'libs/anim8'
local bump = require 'libs/bump'
local Basics = require 'libs/basics'

local Player = {}
Player.__index = Player

function Player:new(world, x, y)
    local this = {
        x = x,
        y = y,
        speed = 40,
        spriteSheet = love.graphics.newImage('assets/sprites/player/ghost.png'),
        gunImage = love.graphics.newImage('assets/sprites/player/gun.png'),
        isFlipped = false,
        world = world
    }
    this.grid = anim8.newGrid(15, 16, this.spriteSheet:getWidth(), this.spriteSheet:getHeight())
    this.animations = {
        walk = anim8.newAnimation(this.grid('1-2', 1), 0.2)
    }
    world:add(this, x, y, 15, 16)
    setmetatable(this, Player)
    return this
end

function Player:update(dt)
    local dx, dy = 0, 0
    if love.keyboard.isDown('w') then dy = -self.speed * dt end
    if love.keyboard.isDown('s') then dy = self.speed * dt end
    if love.keyboard.isDown('a') then dx = -self.speed * dt end
    if love.keyboard.isDown('d') then dx = self.speed * dt end

    self.x, self.y, collisions, len = self.world:move(self, self.x + dx, self.y + dy)
    if dx ~= 0 or dy ~= 0 then
        self.animations.walk:update(dt)
    end

    -- Flip and rotate towards the mouse
    local mx, my = love.mouse.getPosition()
    mx, my = Cam:worldCoords(mx, my)
    local angle = math.atan2(((my-3) - self.y), (mx-4 - self.x))
    self.isFlipped = mx < self.x
    self.gunAngle = angle
end

function Player:draw()
    local scaleX = self.isFlipped and -1 or 1
    self.animations.walk:draw(self.spriteSheet, self.x, self.y, 0, scaleX, 1, 7.5, 8)

    -- Adjust gun position based on the player's flip state
    local gunOffsetX = self.isFlipped and -4.5 or 4.5
    local gunOffsetY = 3.5
    love.graphics.draw(self.gunImage, self.x+4, self.y+3,  self.gunAngle+(math.rad(180)*(scaleX-1)), 1, scaleX, 4.5, 3.5)
end

return Player
