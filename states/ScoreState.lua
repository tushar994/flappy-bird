ScoreState = Class{__includes = BaseState}

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('count')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Your Score Was', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(gScore), 0, 100, VIRTUAL_WIDTH, 'center')
end

