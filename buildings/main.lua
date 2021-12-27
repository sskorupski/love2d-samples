-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
StackAsset = require("stack-asset.stack-asset")
MouseLines = require("dev-helpers.mouse-lines")

Frame = require("dev-helpers.frame")

love.window.setTitle("buildings" )

math.randomseed(os.time())

function love.load()
    randoms = generateRandom(5 + math.random(12), 10)
    image = love.graphics.newImage("assets/etage.png")
    stackDrawer = StackAsset:new({
        image = image,
        offset = 10
    })
    mouseLines = MouseLines:new()
    
    --frames = Frame:generateByCountAndMax(#randoms, math.max(unpack(randoms)))
    frames = Frame:generateByMaxValues(randoms)
    
end

function generateRandom(nbRandom, maxRandom)
    math.randomseed(os.time())
    local randoms = {}
    for i=0, nbRandom do
        table.insert(randoms, math.random(maxRandom))
    end
    return randoms
end

function love.update(dt)
    for i=1, #randoms do
        frames[i]:update(dt)
    end
end

function love.draw()

    require("dev-helpers.grid-helper"):drawHorizontals(10)
    require("dev-helpers.grid-helper"):drawCenters()
    require("dev-helpers.mouse-info"):drawPosition()

    local x = 0
    local y = 0
    
    local levelOffset = 10

    local xOffset = 40 --+ math.random(10)

    for i=1, #randoms do
        local levels = math.min(math.ceil(frames[i].idx), randoms[i])
        stackDrawer:drawBottomTop(xOffset * (i-1), 200, levels, image, 10)
    end

    for i=1, #randoms do
        local levels = math.min(math.ceil(frames[i].idx), randoms[i])
        stackDrawer:drawTopBottom(xOffset * (i-1), 250, levels, image, 10)
    end

    mouseLines:draw()
end

function love.keypressed(key, scancode, isrepeat)
    mouseLines:key(key, true)
end

function love.keyreleased( key, scancode )
    mouseLines:key(key, false)
end