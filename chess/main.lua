-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
Piece = require("piece.piece")
love.window.setTitle( "chess" )

function love.load()
    images = {}
    pieces = {{},{}}
    initImages()
    squareWidth = 50
    initPieces()
end

function initImages()
    function assetResolver(color, piece)
        local path = string.format("assets/%s_%s.png", piece, color)
        return love.graphics.newImage(path)
    end

    local names = {"cavalier", "fou", "pion", "reine", "roi", "tour"}
    local colors = {"blanc", "noir"}

    for colorIdx= 1, #colors do
        images[colorIdx] = {}
        for nameIdx= 1, #names do
            local name = names[nameIdx]
            images[colorIdx][name] = assetResolver(colors[colorIdx], name)
        end
    end
end

function initPieces()
    scale = squareWidth / images[1]["cavalier"]:getHeight()
    offset = (images[1]["cavalier"]:getHeight() * scale - images[1]["cavalier"]:getHeight() * scale * 0.85 )
    scale = scale * 0.85
    
    local notPawns = {"tour", "cavalier", "fou", "reine", "roi", "fou", "cavalier", "tour"}
    local ACharValue = string.byte("A")
    
    function initNotPawns(row, colorIdx)
        for i=1, #notPawns do 
            local column = string.char(ACharValue + i - 1);
            local name = notPawns[i]
            local p = Piece:new({column = column, row = row, image = images[colorIdx][name], scale = scale, offset = offset})
            table.insert(pieces[colorIdx], p)
            i = i + 1
        end
    end

    function initPawns(row, colorIdx)
        for i=1, #notPawns do 
            local column = string.char(ACharValue + i - 1);
            local p = Piece:new({column = column, row = row, image = images[colorIdx]["pion"], scale = scale, offset = offset})
            table.insert(pieces[colorIdx], p)
            i = i + 1
        end
    end

    initNotPawns(1, 1)
    initPawns(2, 1)
    initPawns(7, 2)
    initNotPawns(8, 2)
end

function love.update(dt)
end

first = {165 / 255 , 200/255, 130/255 }
second = {247/255, 221/255, 114/255 }
third = {130/255, 200/255, 114/255}
squareColors = {first, second, third}

function love.draw()

    board = drawBoard(8, 8, squareWidth)
    drawPieces(board.startX, board.startY, squareWidth)
end

function drawBoard(nbColumn, nbRow, squareWidth)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local boardWith = squareWidth * nbColumn
    local boardHeight = squareWidth * nbRow
    local startX = screenWidth / 2 - boardWith / 2
    local startY = screenHeight / 2 - boardHeight / 2

    for i = 0, nbColumn-1 do
        for j = 0, nbRow-1 do
            local c = (i % 2 + j % 2) % 2
            local color = squareColors[c + 1]
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", startX + squareWidth*i, startY + squareWidth*j, squareWidth, squareWidth)        
        end
    end

    return { startX = startX, startY= startY }
end

function drawPieces(startX, startY, squareWidth)
    love.graphics.setColor(1, 1, 1)
    for colorIdx=1, #pieces do
        for j=1, #pieces[colorIdx] do
            local p = pieces[colorIdx][j]
            love.graphics.draw(p.image, startX + squareWidth*(p:columnIndex()-1),  startY + squareWidth * (p.row - 1), 0, p.scale, p.scale, -p.offset, -p.offset)
        end
    end
end

function columnAt(x)
    local x = x - board.startX
    columnIdx =  math.floor(x / squareWidth)
    if(columnIdx >= 0 and columnIdx < 8) then
        return string.char(string.byte("A") + columnIdx)
    end
end

function rowAt(y)
    local y = y - board.startY
    rowIdx =  math.ceil(y / squareWidth)
    if(rowIdx > 0 and rowIdx <= 8) then
        return rowIdx
    end
end

function coordinatesAt(x, y)
    col = columnAt(x)
    row = rowAt(y)
    if(col and row) then
        return {col, row}
    end
end

function love.mousepressed(x, y, button, isTouched, count)
	if button == 1 or isTouched then
        local coordinates = coordinatesAt(x,y)
        if(coordinates) then
            print(columnAt(x))
            print(rowAt(y))
        end
	end
end