-- tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

io.stdout:setvbuf("no")
love.window.setTitle("beat-em-all" )
math.randomseed(os.time())

DebugInfo = require("helper.debug-info")

local animationType = "run"
ennemies = {}

function loadHero()
    local img = love.graphics.newImage("assets/knight-blue.png")

    local width = 56
    local height = 32
    knight = require("hero"):new({
        x = love.graphics.getWidth() / 2 ,
        y = love.graphics.getHeight() / 2,
        r = 0,
        sx = 5,
        sy = 5,
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
end

function loadEnnemy()
    local img = love.graphics.newImage("assets/knight-gold.png")

    local width = 56
    local height = 32
    local ennemy = require("ennemy"):new({
        x = 0 ,
        y = img:getHeight(),
        r = 0,
        sx = 5,
        sy = 5,
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
    ennemy.frames.idle = require("helper.animation"):buildQuads(img, 5, startX, 48 - height, frameXOffset, width, height)
    ennemy.frames.run = require("helper.animation"):buildQuads(img, 8, startX, 112 - height, frameXOffset, width, height)
    ennemy.frames.attack = require("helper.animation"):buildQuads(img, 6, startX, 304 - height, frameXOffset, width, height)
    ennemy.frames.damaged = require("helper.animation"):buildQuads(img, 1, startX, 368 - height, frameXOffset, width, height)
    ennemy.frames.dead = require("helper.animation"):buildQuads(img, 7, startX, 432 - height, frameXOffset, width, height)

    ennemy.actionAnimation = {
        default = "idle",
        right = "run",
        left = "run",
        up = "run",
        down = "run",
        attack = "attack",
    }
    ennemy.animation = {
        type = "idle",
        default = "idle",
        time = 0,
        speed = 10
    }
    ennemy.target = knight
    table.insert(ennemies, ennemy)
end

function love.load()
    loadHero()
    loadEnnemy()

    characters = { knight }
    for i=1, #ennemies do
        table.insert(characters, ennemies[i])
    end
end



function love.update(dt)
    if DebugInfo.idle then return end

    knight:update(dt)
    
    for i=1, #ennemies do
        ennemies[i]:update(dt)
    end
end

function sortCharacters(c1, c2)
    return c1.y < c2.y
end

function love.draw()
    table.sort(characters, sortCharacters)
    for i=1, #characters do
        characters[i]:draw()
    end
    showDebugInfos()
   
    DebugInfo:draw()
end

function showDebugInfos()
    y = 0
    -- debug
    local ennemiesActionInfo = {}
    local i = 1
    for k, v in pairs(ennemies[1].actions) do
        local activeTxt = ennemies[1].actions[k].active and 'true' or 'false'
        table.insert(ennemiesActionInfo, k .. ": " .. activeTxt)    
        i = i + 1
    end
    y = DebugInfo:show(0, y, ennemiesActionInfo)

    local positions = {
        "hero: " .. string.format("%.3f", knight.x)  .. " " ..  string.format("%.3f", knight.y),
        "ennemy: " ..  string.format("%.3f", ennemies[1].x) .. " " ..  string.format("%.3f", ennemies[1].y),
    }
    y = DebugInfo:show(0, y, positions)
    y = DebugInfo:show(0, y, { "hero_animation: " .. knight.animation.type })
end

function love.keypressed(key, scancode, isrepeat)
    DebugInfo:key(key, true)
    if DebugInfo.idle then return end
    knight:key(key, true)
end

function love.keyreleased( key, scancode )
    DebugInfo:key(key, false)
    if DebugInfo.idle then return end
    knight:key(key, false)
    
end

function love.textinput(t)
    if DebugInfo.idle then 
        DebugInfo.input = DebugInfo.input .. t 
    end
end