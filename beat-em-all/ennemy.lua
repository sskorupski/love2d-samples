-- Meta class
Ennemy = {
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
        },
        left = {
            active = false, 
        },
        up = {
            active = false,
        },
        down = {
            active = false,
        },
        attack = { 
            active = false,
        }
    },
    speed = {
        x = 50,
        y = 50,
    }
}

function Ennemy:new(o)
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

function Ennemy:distanceToHero()
    local x = self.target.x - self.x
    local y = self.target.y - self.y
    return x, y
end


function Ennemy:update(dt)
    local dX, dY = self:distanceToHero()
    if dX > 100 then
        self.actions.right.active = true
        self.actions.left.active = false
    elseif dX < -100 then
        self.actions.right.active = false
        self.actions.left.active = true
    else
        self.actions.right.active = false
        self.actions.left.active = false
    end
    if dY > 50 then
        self.actions.down.active = true
        self.actions.up.active = false
    elseif dY < -50 then
        self.actions.down.active = false
        self.actions.up.active = true
    else
        self.actions.down.active = false
        self.actions.up.active = false
    end

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

function Ennemy:draw()
    if self.frames[self.animation.type] == nil then
            print("ohohoh")
    end
    local frameIdx = ( math.floor(self.animation.time) % #self.frames[self.animation.type] ) + 1
    local frame = self.frames[self.animation.type][frameIdx]
    love.graphics.draw(self.image, frame, self.x, self.y, 0, self.sx, self.sy, self.ox, self.oy)
end

return Ennemy
