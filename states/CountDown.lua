CountDown = Class{__includes = BaseState}

function CountDown:init()
    self.time = 3
end

function CountDown:update(dt)
    self.time = self.time - dt
    if self.time <=0 then
        gStateMachine:change('play')
    end
end

function CountDown:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf(tostring(math.floor(self.time)+1), 0, 64, VIRTUAL_WIDTH, 'center')
end