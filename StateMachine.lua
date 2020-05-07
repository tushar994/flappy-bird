StateMachine = Class()

function StateMachine:init(parameters)

    self.empty = {
        render = function() end,
        update = function() end,
        exit = function() end,
        enter = function() end,
    }

    self.currentState = self.empty
    self.states = parameters or {}

end

-- it changes the current state
-- self.states[stateName] must be a function that returns the appropriate gamestate 
-- object
function StateMachine:change(stateName, parameters)
    assert(self.states[stateName])
    self.currentState:exit()
    self.currentState = self.states[stateName]()
    self.currentState:enter(parameters)
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end
