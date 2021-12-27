-- Meta class
MouseHelper = {}

function MouseHelper:drawPosition(mode, color)
    local posX, posY = love.mouse.getPosition()
    local color = color or {255, 255, 255}
    love.graphics.setColor(color)
    
    local font = love.graphics.newFont(12)
    love.graphics.setFont( font )
    
    local where = mode or "bottomRight"
    local x, y = 0
    local alignment = "left"

    if where == "topLeft" then
        x = 25
        y = 25
    elseif where == "topCenter" then
        x = love.graphics.getWidth() / 2 - math.max(font:getWidth("mouseX=" .. posX), font:getWidth("mouseY=" .. posY))
        y = 25
        alignment = "center"
    elseif where == "topRight" then
        x = love.graphics.getWidth() - 100
        y = 25
    elseif where == "bottomLeft" then
        x = 25
        y = love.graphics.getHeight() - 50
    elseif where == "bottomCenter" then
        x = love.graphics.getWidth() / 2 - math.max(font:getWidth("mouseX=" .. posX), font:getWidth("mouseY=" .. posY))
        y = love.graphics.getHeight() - 50
        alignment = "center"
    elseif where == "bottomRight" then
        x = love.graphics.getWidth() - 100
        y = love.graphics.getHeight() - 50       
    end

    love.graphics.printf("mouseX=" .. posX, x, y, 125, alignment)
    love.graphics.printf("mouseY=" .. posY, x, y + 25, 125, alignment)
end

return MouseHelper
