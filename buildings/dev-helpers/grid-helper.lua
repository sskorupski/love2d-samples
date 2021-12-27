-- Meta class
GridHelper = {}

function GridHelper:drawHorizontals(yOffset, color)
    local maxX = love.graphics.getWidth()
    local nbLines = math.floor(love.graphics.getHeight() / yOffset)
    local color = color or {255, 255, 255}
    love.graphics.setColor(color)
    for i=1, nbLines do
        local y = yOffset * (i-1)
        love.graphics.line(0, y, maxX, y)
    end
end

function GridHelper:drawCenters(color)
    local color = color or {255, 255, 255}
    love.graphics.setColor(color)
    love.graphics.line(love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())
end

return GridHelper
