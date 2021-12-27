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
    fillBoard(410, 300, 250, 20, 30, squareColors)
end

-- Fill a defined area with squares having alternated colors
-- The number of rows and columns is computed from the area width, height and the square side 
function fillBoard(width, height, startX, startY, squareSide, colors)
    local x = startX
    local y = startY
    local i = 0
    local j = 0
    while x < startX + width - squareSide do
        x = startX
        y = startY
        j = 0
        while y < startY + height - squareSide do
            local c = (i % #colors + j % #colors) % #colors
            local color = colors[c + 1]
            x = startX + squareSide * i
            y = startY + squareSide * j
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", x, y, squareSide, squareSide)        
            j = j + 1
        end
        i = i + 1
    end
end

function love.keypressed(key)
end
