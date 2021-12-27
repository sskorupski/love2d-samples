-- Meta class
LifeBar = {orientation = "h", x = 0, y = 0, images = {}, offset = 0}

-- Derived class method new

function LifeBar:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function LifeBar:setOrientationHorizontal()
    self.orientation = "h"
end

function LifeBar:setOrientationVertical()
    self.orientation = "v"
end

function LifeBar:draw(lifePoints)
    if(self.orientation == "h") then
        for i = 1, lifePoints * #self.images do
            local imgIdx = (i-1) % #self.images + 1
            love.graphics.draw(self.images[imgIdx], self.x + (self.images[imgIdx]:getWidth() + self.offset) * (i-1) , self.y, 0)
        end
    elseif(self.orientation == "v") then
        for i=1, lifePoints * #self.images do
            local imgIdx = (i-1) % #self.images + 1
            local y = (math.ceil( i / #self.images)-1) * self.images[imgIdx]:getHeight()
            local x = self.x + self.images[imgIdx]:getWidth() * ((i-1) % #self.images)
            love.graphics.draw(self.images[imgIdx], x , y, 0)
        end
    end
end

return LifeBar