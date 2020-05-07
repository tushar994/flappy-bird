PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.parallelpipes = {}
    self.timer = 0;
    self.respawntime  = 1.5 + math.random()
    
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    gScore =0
end

function PlayState:enter(list)
    if list then
        self.bird = list['bird']
        self.parallelpipes= list['pipes']
        self.lastY = list['lastY']
        self.timer = list['timer']
        self.respawntime = list['respawnTime']
        gScore = list['score']
        sounds['music']:play()
    end
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then
        print("okay")
        gPausedNot = false
        gStateMachine:change('pause',{
            ['bird'] = self.bird,
            ['pipes'] = self.parallelpipes,
            ['timer'] = self.timer,
            ['lastY'] = self.lastY,
            ['respawnTime'] = self.respawntime,
            ['score'] = gScore,
        })
    end
    
    self.timer = self.timer + dt

    if self.timer>=self.respawntime then
        local Y = math.max(-PIPE_HEIGHT + 10 , math.min(self.lastY + math.random(-20,20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = Y
        table.insert(self.parallelpipes,ParallelPipe(self.lastY))
        self.timer =0;
        -- print(tostring(self.respawntime))
        self.respawntime  = 1.5 + math.random()
    end


    for k,pair in pairs(self.parallelpipes) do
        pair:update(dt)
    end

    for k,pair in pairs(self.parallelpipes) do
        if pair.cross == false and pair.x < self.bird.x then
            sounds['score']:play()
            pair.cross = true
            gScore = gScore+ 1
        end
    end

    for k,pair in pairs(self.parallelpipes) do 
        if pair.remove then
            table.remove(self.parallelpipes,k)
        end
    end

    for k,pair in pairs(self.parallelpipes) do 
        for j,pipe in pairs(pair.Pipes) do 
            if self.bird:collision(pipe) then
                sounds['hurt']:play()
                gStateMachine:change('score')
            end
        end
    end

    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('score')
    end

    self.bird:update(dt)
-- to pause
    
end

function PlayState:render()
    
    for k, pair in pairs(self.parallelpipes) do
        pair:render()
    end
    
    self.bird:render()
    
    love.graphics.setFont(flappyFont)
    love.graphics.printf(tostring(gScore),15,15,50,'left')
end
