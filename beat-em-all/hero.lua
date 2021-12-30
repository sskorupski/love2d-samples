-- Meta class
Hero = {
    image = {},
    x = 0,
    y = 0,
    sx = 1,
    sy = 1,
    ox = 0,
    oy = 0,
    r = 0,
    frames = {},
    actionAnimation = {},
    animation = {
        type = nil,
        tmpType = nil,
        time = 0,
        speed = 5
    },
    actions = {
        right = {
            active = false, 
            keys = {"right"},
        },
        left = {
            active = false, 
            keys = {"left"} ,
        },
        up = {
            active = false,
            keys = {"up"},
        },
        down = {
            active = false,
            keys = {"down"},
        },
        attack = { 
            active = false,
            keys = {"space"},
        }
    },
    speed = {
        x = 50,
        y = 50,
    }
}

function Hero:new(o)
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


function Hero:key(key, enable)
    -- active/unactive action
    for  _, action in pairs(self.actions) do
        if hasValue(action.keys, key) then
            action.active = enable
        end
    end

    -- update animation type
    if not self.actions.attack.active then
        local nextAnimation
        for  key, action in pairs(self.actions) do
            if action.active and self.actionAnimation[key] ~= nil then
                nextAnimation = self.actionAnimation[key]
                break;
            end
        end
        if self.animation.type ~= nextAnimation then
            self.animation.time = 0
        end
        if nextAnimation ~= nil then
            self.animation.type = nextAnimation
        else
            self.animation.type = self.animation.default
        end
    else 
        self.animation.time = 0
        if self.actionAnimation.attack ~= nil then
            self.animation.type = self.actionAnimation.attack
        end
    end

    -- switch image direction
    if self.actions.right.active then
        self.sx = math.abs(self.sx)
    elseif self.actions.left.active then
        self.sx = -math.abs(self.sx)
    end
end

function Hero:update(dt)
   self.animation.time = self.animation.time + dt * self.animation.speed

    if not self.actions.attack.active then
        if self.actions.right.active then
            self.x = self.x + dt * self.speed.x
        end
        if self.actions.left.active then
            self.x = self.x - dt * self.speed.x
        end

        if self.actions.up.active then
            self.y = self.y - dt * self.speed.y
        end
        if self.actions.down.active then
            self.y = self.y + dt * self.speed.y
        end
    end
end

function Hero:draw()
    if(self.frames[self.animation.type] == nil) then
            print("ohohoh")
    end
    local frameIdx = ( math.floor(self.animation.time) % #self.frames[self.animation.type] ) + 1
    local frame = self.frames[self.animation.type][frameIdx]
    love.graphics.draw(self.image, frame, self.x, self.y, 0, self.sx, self.sy, self.ox, self.oy)
end

return Hero
