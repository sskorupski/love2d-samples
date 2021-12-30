-- Meta class
DebugInfo = {
    idle = false,
    evaluateKey = "f12",
    input = "",

}

function DebugInfo:show(x, y, infos)
    local color = color or {255, 255, 255}
    love.graphics.setColor(color)
    
    local font = love.graphics.newFont(12)
    love.graphics.setFont( font )
    
    local tmpY = y
    for i=1, #infos do
        love.graphics.printf(infos[i], x, tmpY, 800 , "right")
        tmpY = tmpY + font:getHeight(infos[i])
    end
    return tmpY
end

function DebugInfo:key(k, pressed)
    if k == self.evaluateKey and pressed then
        self.idle = not self.idle
        if not self.idle then
            self:eval(self.input)
            self.input = ""
        end
    end

    if self.idle then
        if k == "backspace" and not pressed then
            self.input = self.input:sub(1, -2)
        end
        if (k == "return" or k == "kpenter") and not pressed then
            self:eval(self.input)
            self.input = ""
        end
    end
end

function DebugInfo:draw()
    if self.idle then
        local font = love.graphics.newFont(12)
        love.graphics.rectangle("fill", 5, love.graphics.getHeight() - font:getHeight(" "), love.graphics.getWidth() - 10, font:getHeight(" "), 5, 5)
        love.graphics.setColor({0,0,0})
        love.graphics.printf(self.input, 0, love.graphics.getHeight() - font:getHeight(" "), love.graphics.getWidth(), "center")
        love.graphics.setColor({255,255,255})
    end
end

function DebugInfo:print(err, ansi)
    local ansi = ansi or 32
    print('\27['.. ansi .. 'm' .. err .. '\27[0m')
end



-- evaluate a txt as an expression
function DebugInfo:eval(txt)
    local func, err = load("return function() ".. txt .. " end")
    if (err) then
        self:print(txt)
        self:print(err, 31)
    end
    if func then
        local success, expression = pcall(func)
        if(success) then
            local result = expression()
            if(result) then
                self:print(txt)
                self:print(result, 33)
            end
        end
    end
end

return DebugInfo
