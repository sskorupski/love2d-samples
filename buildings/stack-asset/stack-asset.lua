-- Meta class
StackAsset = {}

-- Derived class method new

function StackAsset:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

--- Draw a stack from the bottom to the top
-- @param x : the start x position
-- @param y : the start y position
-- @param levels : the number of stackable elements to print
-- @param image : the number of stackable elements to print
-- @param offset : The offset to apply for drawing one level above the other
function StackAsset:drawBottomTop(x, y, levels, image, offset)
    love.graphics.setColor(255,255,255)
    -- From bottom to top
    for i=levels, 1, -1 do
        local tmpY = y - image:getHeight() - offset * (levels - i)
        love.graphics.draw(image, x , tmpY, 0)
    end
end

--- Draw a stack from the bottom to the top
-- @param x : the start x position
-- @param y : the start y position
-- @param levels : the number of stackable elements to print
-- @param image : the number of stackable elements to print
-- @param offset : The offset to apply for drawing one level above the other
function StackAsset:drawTopBottom(x, y, levels, image, offset)
    love.graphics.setColor(255,255,255)
    -- From bottom to top
    for i=levels, 1, -1 do
        local tmpY = image:getHeight() + y + offset * (levels - i)
        love.graphics.draw(image, x + image:getWidth()  , tmpY, 0, -1)
    end
end


return StackAsset