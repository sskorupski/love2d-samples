-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")

love.window.setTitle( "colored-grid-filler" )

function love.load()
end

function love.update(dt)
end

first = {165 / 255 , 200/255, 130/255 }
second = {247/255, 221/255, 114/255 }
third = {130/255, 200/255, 114/255}
squareColors = {first, second, third}

function love.draw()
    drawBoard(8, 8, 50)
end

function drawBoard(nbColumn, nbRow, squareWidth)
    for i = 1, nbColumn do
        for j = 1, nbRow do
            local c = (i % 2 + j % 2) % 2
            local color = squareColors[c + 1]
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", squareWidth*i, squareWidth*j, squareWidth, squareWidth)        
        end
    end
    
end

