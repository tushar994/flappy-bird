push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'ParallelPipe'
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleState'
require 'states/CountDown'
require 'states/ScoreState'
require 'states/PauseState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_HEIGHT = 288
VIRTUAL_WIDTH = 512

-- background and ground
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0
local BACKGROUND_SCROll_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0
local GROUND_SCROll_SPEED = 60

gPausedNot = true

--BIRD
--local bird = Bird()

--parrallelpipes
--local parallelpipes = {}

--timer
--local spawnTimer =0;

--spawn height of pipe
--local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- this is the function called once at the starting that sets up the window and all that
function love.load()
    math.randomseed(os.time())
    
    love.graphics.setDefaultFilter('nearest','nearest')
    
    sounds = {
        ['jump'] = love.audio.newSource('music/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('music/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('music/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('music/score.wav', 'static'),

        -- https://freesound.org/people/xsgianni/sounds/388079/
        ['music'] = love.audio.newSource('music/marios_way.mp3', 'static')
    }

    love.window.setTitle('bruh')
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizable = true
    })


    love.keyboard.keysPressed = {}

    gStateMachine = StateMachine{
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
        ['count'] = function() return CountDown() end,
        ['score'] = function() return ScoreState() end,
        ['pause'] = function() return PauseState() end,
    }

    gStateMachine:change('title')

    sounds['music']:setLooping(true)
    sounds['music']:play()

end

-- function called whenever we want to resize something
function love.resize(w,h)
    push:resize(w,h)
end

-- function called whenever a key is pressed
function love.keypressed(key)

    -- for the controls
    love.keyboard.keysPressed[key] = true


    if key=='escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] == true then
        return true
    else
        return false
    end
end


function love.update(dt)
    
    if gPausedNot then
        backgroundScroll = (backgroundScroll + (BACKGROUND_SCROll_SPEED*dt) )% BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + (GROUND_SCROll_SPEED*dt))%VIRTUAL_WIDTH
    end
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
      
end

-- function that is called to draw something
function love.draw()
    push:start()
    


    --background
    love.graphics.draw(background,-backgroundScroll,0)
    
    -- everything else
    gStateMachine:render()

    --ground
    love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-16)
    
    push:finish()

end
