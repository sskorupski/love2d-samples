-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
love.window.setTitle("lander" )


math.randomseed(os.time())
local ship = {}
local gravity = 1

function love.load()
    local img = love.graphics.newImage("assets/ship.png")
    ship = require("ship"):new({
        image = img,
        engine = love.graphics.newImage("assets/engine.png"),
        x = love.graphics.getWidth() / 2 - img:getWidth() / 2,
        y = love.graphics.getHeight() / 2 - img:getHeight() / 2,
        r = math.rad(-90),
        ox = img:getWidth() / 2,
        oy = img:getHeight() / 2,
    })
end

function love.update(dt)
    ship:update(dt)
    ship.speed.y = ship.speed.y + dt * gravity 
end

function love.draw()
    love.graphics.draw(ship.image, ship.x, ship.y, ship.r, 1, 1, ship.ox, ship.oy)
    if ship.actions.forward.active then
        love.graphics.draw(ship.engine, ship.x, ship.y, ship.r, 1, 1, ship.engine:getWidth()/2, ship.engine:getHeight()/2)
    end
    ship:draw()
end

function love.keypressed(key, scancode, isrepeat)
    ship:key(key, true)
end

function love.keyreleased( key, scancode )
    ship:key(key, false)
end