Pipe = Class()

local PIPE_IMAGE = love.graphics.newImage('pipe.png')

PIPE_HEIGHT = 288
PIPE_WIDTH = PIPE_IMAGE:getWidth()
-- setting the speed of the pipes
PIPE_SPEED = 60


local PIPE_SCROll = -60

function Pipe:init(orientation,y)
    self.x = VIRTUAL_WIDTH
    
    self.y = y

    self.width = PIPE_WIDTH
    self.height = PIPE_IMAGE:getHeight()

    self.orientation = orientation
end



function Pipe:render()
    love.graphics.draw(PIPE_IMAGE,self.x,
    (self.orientation=='top' and self.y+PIPE_HEIGHT or self.y),
    0, -- rotation
    1,  -- scale X
    self.orientation=='top' and -1 or 1 )-- scale Y)
end