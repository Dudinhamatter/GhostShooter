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
        acceleration = 200,
        deceleration = 100,
        maxSpeed = 100,
        velocity = {x = 0, y = 0},
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
    local ax, ay = 0, 0
    if love.keyboard.isDown('w') then ay = -self.acceleration end
    if love.keyboard.isDown('s') then ay = self.acceleration end
    if love.keyboard.isDown('a') then ax = -self.acceleration end
    if love.keyboard.isDown('d') then ax = self.acceleration end

    self.velocity.x = self.velocity.x + ax * dt
    self.velocity.y = self.velocity.y + ay * dt

    -- Apply deceleration when no input
    if ax == 0 then
        if self.velocity.x > 0 then
            self.velocity.x = math.max(0, self.velocity.x - self.deceleration * dt)
        elseif self.velocity.x < 0 then
            self.velocity.x = math.min(0, self.velocity.x + self.deceleration * dt)
        end
    end

    if ay == 0 then
        if self.velocity.y > 0 then
            self.velocity.y = math.max(0, self.velocity.y - self.deceleration * dt)
        elseif self.velocity.y < 0 then
            self.velocity.y = math.min(0, self.velocity.y + self.deceleration * dt)
        end
    end

    -- Clamp velocity to max speed
    self.velocity.x = math.max(-self.maxSpeed, math.min(self.maxSpeed, self.velocity.x))
    self.velocity.y = math.max(-self.maxSpeed, math.min(self.maxSpeed, self.velocity.y))

    -- Update position
    self.x, self.y, collisions, len = self.world:move(self, self.x + self.velocity.x * dt, self.y + self.velocity.y * dt)

    if self.velocity.x ~= 0 or self.velocity.y ~= 0 then
        self.animations.walk:update(dt)
    end

    -- Flip and rotate towards the mouse
    local mx, my = love.mouse.getPosition()
    mx, my = Cam:worldCoords(mx, my)
    local angle = math.atan2(((my+2) - self.y), (mx - self.x))
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
