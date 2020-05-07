Bird = Class()

local GRAVITY = 20
local JUMP_STRENGTH = -5

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH/2 - ( self.width/2)
    BIRD_POSITION = self.x
    self.y = VIRTUAL_HEIGHT/2 - (self.height/2) 

    self.dy =0
end

function Bird:render()
    love.graphics.draw(self.image, self.x,self.y)
end

function Bird:update(dt)
    -- create illusion of gravity by updating speed
    self.dy = self.dy + GRAVITY * dt
    -- jump
    if love.keyboard.wasPressed('space') then
        sounds['jump']:stop()
        self.dy = JUMP_STRENGTH
        sounds['jump']:play()
    end
    -- update position
    self.y = self.y + self.dy
end

function Bird:collision(pipe)
    if self.y +2 > pipe.y + PIPE_HEIGHT or self.y+self.height < pipe.y + 2 or self.x+self.width<pipe.x + 2 or self.x + 2 > pipe.x+PIPE_WIDTH then
        return false
    else
        return true
    end


end