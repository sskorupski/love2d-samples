-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
Frame = require("dev-helpers.frame")
Weapon = require("weapon")

love.window.setTitle("buildings" )

math.randomseed(os.time())

function love.load()
    weapon = Weapon:new()
end

function love.update(dt)
    weapon:update(dt)
end

function love.draw()
    weapon:draw()
end

function love.keypressed(key, scancode, isrepeat)
    weapon:key(key, true)
end

function love.keyreleased( key, scancode )
    weapon:key(key, false)
end