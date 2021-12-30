-- Meta class
Ship = {
    image = {},
    engine = {},
    x = 0,
    y = 0,
    ox = 0,
    oy = 0,
    r = 0,
    actions = {
        turnRight = {
            active = false, 
            keys = {"right"}
        },
        turnLeft = {
            active = false, 
            keys = {"left"} 
        },
        forward = {
            active = false,
            keys = {"up"}
        }
    },
    speed = {
        x = 0,
        y = 0,
        coef = 3
    },
    turnCoef = 5,
}

function Ship:new(o)
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


function Ship:key(key, enable)
    for  _, action in pairs(self.actions) do
        if hasValue(action.keys, key) then
            action.active = enable
        end
    end
end

function Ship:update(dt)
    if self.actions.turnRight.active then
        self.r = self.r + dt * self.turnCoef
    end
    if self.actions.turnLeft.active then
        self.r = self.r - dt * self.turnCoef
    end
    if self.actions.forward.active then
        self.speed.x = self.speed.x + dt * math.cos(self.r) * self.speed.coef
        self.speed.y = self.speed.y + dt * math.sin(self.r) * self.speed.coef
    end

    self.y = self.y + self.speed.y
    self.x = self.x + self.speed.x
end

function Ship:draw()
    love.graphics.print("Hello", 0, 0)
    love.graphics.printf("speed=" .. -self.speed.y, 25, 25, 125, "left")
end

return Ship
