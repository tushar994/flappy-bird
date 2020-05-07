ParallelPipe = Class()


function ParallelPipe:init(y)
    -- init x to the right of the screen
    self.x = VIRTUAL_WIDTH + 32
    local GAP_HEIGHT = math.random(-20,20) + 100

    self.y = y
    
    
    self.Pipes = {
        ['upper'] = Pipe('top',self.y),
        ['lower'] = Pipe('botton', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    self.remove = false
    self.cross  = false
end


function ParallelPipe:update(dt)
    if self.x> -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED*dt
        self.Pipes['upper'].x = self.x
        self.Pipes['lower'].x = self.x
    else
        self.remove = true
    end
end

function ParallelPipe:render()
    for k,pipe in pairs(self.Pipes) do
        pipe:render()
    end
end