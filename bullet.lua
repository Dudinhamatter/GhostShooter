local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(world, x, y, angle)
    local this = {
        type='bullet',
        x = x,
        y = y,
        speed = 200,
        angle = angle,
        sprite = love.graphics.newImage('assets/sprites/player/bullet.png'),
        world = world,
        isAlive = true
    }
    this.width = this.sprite:getWidth()
    this.height = this.sprite:getHeight()
    world:add(this, this.x, this.y, this.width, this.height)
    setmetatable(this, Bullet)
    return this
end

function Bullet:update(dt)
    if not self.isAlive then return end

    local dx = math.cos(self.angle) * self.speed * dt
    local dy = math.sin(self.angle) * self.speed * dt
    self.x, self.y, collisions, len = self.world:move(self, self.x + dx, self.y + dy, self.filter)

    -- Check if the bullet is outside the screen
    if self.x < (-160/2)+6 or self.y < (-144/2)+6 or self.x > (160/2)-6 or self.y > (144/2)-6 then
        self:destroy()
    end
end

function Bullet:draw()
    if self.isAlive then
        love.graphics.draw(self.sprite, self.x, self.y, self.angle, 1, 1, self.width / 2, self.height / 2)
    end
end

function Bullet:destroy()
    self.world:remove(self)
    self.isAlive = false
    print("Bullet removed")
end

function Bullet:filter(other)
    if other.type == 'player' or other.type == 'bullet' then
        return 'cross'
    else
        return 'slide'
    end
end

return Bullet
