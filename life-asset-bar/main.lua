-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
LifeBar = require("life-bar.life-bar")
love.window.setTitle( "life-asset-bar" )

function love.load()
    lifePoints = 2
    local image = love.graphics.newImage("assets/coeur.png")
    local imageA = love.graphics.newImage("assets/coeur_gauche.png")
    local imageB = love.graphics.newImage("assets/coeur_droite.png")
    lifeBar = LifeBar:new({ x=100, images = { imageA, imageB } })
end

function love.update(dt)
    lifePoints = lifePoints + dt
end

function love.draw()
    lifeBar:draw(lifePoints)
end