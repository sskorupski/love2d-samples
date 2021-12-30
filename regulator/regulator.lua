-- Meta class
Regulator = {
    increment = 1,
    actions = {
        increaseMax = {
            active = false, 
            keys = {"kp+"},
            repetitionDelay = 0.3,
            lastTime = 0,
            incMultiplier = 1
        },
        decreaseMax = {
            active = false, 
            keys = {"kp-"},
            repetitionDelay = 0.3,
            lastTime = 0,
            incMultiplier = -1
        }
    },
    value = 0,
    min = 0,
    max = 10
}

function Regulator:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

local function hasValue (tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function Regulator:key(key, enable)
    for  _, action in pairs(self.actions) do
        if hasValue(action.keys, key) then
            action.active = enable
        end
    end
end

function Regulator:update(dt)
    for  _, action in pairs(self.actions) do
        if action.active then
            local repetitionCondition = love.timer.getTime() - action.lastTime > action.repetitionDelay
            if repetitionCondition then
                action.lastTime = love.timer.getTime()
                local nextValue = self.value + self.increment * action.incMultiplier
                if (nextValue >= self.min) and (nextValue <= self.max) then
                    self.value = nextValue
                end
            end
        end
    end
end

return Regulator
