PauseState = Class{__includes = BaseState}

function PauseState:init()

end



function PauseState:enter(list)


    self.bird = list['bird']
    self.parallelpipes= list['pipes']
    self.lastY = list['lastY']
    self.timer = list['timer']
    self.respawntime = list['respawnTime']
    gScore =  list['score']
    sounds['music']:pause()


end

function PauseState:update()
    if love.keyboard.wasPressed('p') then
        gPausedNot = true
        gStateMachine:change('play',{
            ['bird'] = self.bird,
            ['pipes'] = self.parallelpipes,
            ['timer'] = self.timer,
            ['lastY'] = self.lastY,
            ['respawnTime'] = self.respawntime,
            ['score'] = gScore
        })
    end
end

function PauseState:exit()

end

function PauseState:render()
    self.bird:render()

    for k, pair in pairs(self.parallelpipes) do
        pair:render()
    end
    

end
