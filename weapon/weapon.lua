-- Meta class
Weapon = {
    shots = {
        first = {
            enabled = false, -- true when the shot key is pressed
            keys = {"space"}, -- The key to press for shooting
            bulletSpeed = 10, -- How fast a bullet is
            bulletRadius = 5,
            ammo = 100, -- The available bullets
        
            fireRate = 0.3, -- The minimum delay between two shot
            lastBullet = 0, -- The last time a bullet has been shot

            burst = true, -- When true, the weapon shot while the key is pressed
            shooting = false, -- State for burst mode

            maxBulletsByBurst = 10, -- When different of 0, limit the number of bullets to shot while the shot key is pressed
            nbBulletsInBurst = 0, -- The number of shot bullets in the current burst
            bullets = {} -- The shot bullets
        },
        second = {
            enabled = false, -- true when the shot key is pressed
            keys = {"a"}, -- The key to press for shooting
            bulletSpeed = 5, -- How fast a bullet is
            bulletRadius = 2,
            ammo = 100, -- The available bullets
        
            fireRate = 0.1, -- The minimum delay between two shot
            lastBullet = 0, -- The last time a bullet has been shot

            burst = true, -- When true, the weapon shot while the key is pressed
            shooting = false, -- State for burst mode

            maxBulletsByBurst = 0, -- When different of 0, limit the number of bullets to shot while the shot key is pressed
            nbBulletsInBurst = 0, -- The number of shot bullets in the current burst
            bullets = {} -- The shot bullets
        }
    }
    active = true -- Does the player is using the weapon
}

function Weapon:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

local function hasValue (tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function Weapon:key(key, enable)
    for  _, shot in pairs(self.shots) do
        if hasValue(shot.keys, key) then
            shot.enabled = enable
            if not enable then
                shot.shooting = false
                shot.nbBulletsInBurst = 0
            end
        end
    end
end

function Weapon:update(dt)
    for  _, shot in pairs(self.shots) do
        if(shot.enabled) then
            local shotDelayCondition = love.timer.getTime() - shot.lastBullet > shot.fireRate
            local burstCondition = ((not shot.burst and not shot.shooting) or shot.burst)
            local maxBurstCondition = shot.maxBulletsByBurst == 0 or shot.nbBulletsInBurst < shot.maxBulletsByBurst
    
            if shot.ammo > 0 and shotDelayCondition and burstCondition and maxBurstCondition then
                shot.shooting = true
                shot.ammo = shot.ammo - 1
                shot.nbBulletsInBurst = shot.nbBulletsInBurst + 1
                shot.lastBullet = love.timer.getTime()
                table.insert(shot.bullets, { x =0, y = 10})
            end
        end

         -- Update bullets position
        local i=1
        while i <= #shot.bullets do
            local bullet = shot.bullets[i]
            bullet.x = bullet.x + shot.bulletSpeed
            
            if not isInsideScreen(bullet) then
                table.remove(shot.bullets, i)
            else
                i = i + 1
            end
        end
    end
    
end

function isInsideScreen(point)
    return point.x > 0 and point.x < love.graphics.getWidth() and
        point.y > 0 and point.y < love.graphics.getHeight() 
end

function Weapon:draw()
    -- draw bullets
    for  _, shot in pairs(self.shots) do
        for b = 1, #shot.bullets do 
            local bullet = shot.bullets[b]
            love.graphics.circle("fill", bullet.x, bullet.y, shot.bulletRadius)
        end 
    end
end

return Weapon
