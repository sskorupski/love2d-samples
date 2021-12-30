-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
Regulator = require("regulator")

love.window.setTitle("regulator" )

math.randomseed(os.time())

function love.load()
    regulator = Regulator:new()
    speed = 0
end

function love.update(dt)
    regulator:update(dt)
    local speedInc = 0
    if regulator.value > speed then
        speedInc = dt
    elseif regulator.value < speed then
        speedInc = -dt
    end
    local nextSpeed = speed + speedInc
    speed = nextSpeed
end

function love.draw()
    love.graphics.printf("regulator=" .. regulator.value, 25, 25, 125, "left")
    love.graphics.printf("speed=" .. speed, 25, 50, 125, "left")

    local maxSpeed = regulator.max
    love.graphics.rectangle("line", 25, 50, 400, 25)
    love.graphics.rectangle("fill", 25, 50, speed/maxSpeed * 400, 25)
end

function love.keypressed(key, scancode, isrepeat)
    regulator:key(key, true)
end

function love.keyreleased( key, scancode )
    regulator:key(key, false)
end