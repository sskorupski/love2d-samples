-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
love.window.setTitle("shoot-them-all" )
math.randomseed(os.time())

local animationType = "run"

function love.load()
    local img = love.graphics.newImage("assets/knight.png")

    local width = 56
    local height = 32
    knight = require("knight"):new({
        x = love.graphics.getWidth() / 2 ,
        y = love.graphics.getHeight() / 2,
        r = 0,
        sx = 3,
        sy = 3,
        ox = 22,
        oy = height, 
        image = img,
        speed = {
            x = 100,
            y = 50
        }
    })

    local startX = 10
    local frameXOffset = 64
    knight.frames.idle = require("helper.animation"):buildQuads(img, 5, startX, 48 - height, frameXOffset, width, height)
    knight.frames.run = require("helper.animation"):buildQuads(img, 8, startX, 112 - height, frameXOffset, width, height)
    knight.frames.attack = require("helper.animation"):buildQuads(img, 6, startX, 304 - height, frameXOffset, width, height)
    knight.frames.damaged = require("helper.animation"):buildQuads(img, 1, startX, 368 - height, frameXOffset, width, height)
    knight.frames.dead = require("helper.animation"):buildQuads(img, 7, startX, 432 - height, frameXOffset, width, height)

    knight.actionAnimation = {
        default = "idle",
        right = "run",
        left = "run",
        up = "run",
        down = "run",
        attack = "attack",
    }
    knight.animation = {
        type = "idle",
        default = "idle",
        time = 0,
        speed = 10
    }
    knight.actions.left.animation = "run"
end


function love.update(dt)
    knight:update(dt)
    
    local i = 1
    for key, _ in pairs(knight.frames) do
        if love.keyboard.isDown("kp"..i) then
            knight.animation.type = key
            knight.animation.time = 0
        end
        i = i + 1
    end
end

function love.draw()
    knight:draw()
    love.graphics.printf("animation=" .. knight.animation.type, 25, 50, 125, alignment)
end

function love.keypressed(key, scancode, isrepeat)
    knight:key(key, true)
end

function love.keyreleased( key, scancode )
    knight:key(key, false)
end