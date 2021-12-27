-- Meta class
MouseLines = {
    drawHorizontalAtPosition = {
        enabled = false,
        keys = {"h", "l"}
    }, 
    drawVerticalAtPosition = {
        enabled = false,
        keys = {"v", "l"}
    }
}

function MouseLines:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

local function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function MouseLines:key(key, enable)
    if hasValue(self.drawHorizontalAtPosition.keys, key) then
        self.drawHorizontalAtPosition.enabled = enable
    end

    if hasValue(self.drawVerticalAtPosition.keys, key) then
        self.drawVerticalAtPosition.enabled = enable
    end
end

function MouseLines:drawHorizontal()
    local _, posY = love.mouse.getPosition()
    love.graphics.setColor(255, 255, 255)
    love.graphics.line(0, posY, love.graphics.getWidth(), posY)
end

function MouseLines:drawVertical()
    local posX, _ = love.mouse.getPosition()
    love.graphics.setColor(255, 255, 255)
    love.graphics.line(posX, 0, posX, love.graphics.getHeight())
end

function MouseLines:draw()
    if self.drawHorizontalAtPosition.enabled then
        self.drawHorizontal()
    end
    if self.drawVerticalAtPosition.enabled then
        self.drawVertical()
    end
end

return MouseLines
