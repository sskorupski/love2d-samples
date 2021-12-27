-- Meta class
Frame = {
    idx = 1, -- the frame index
    dtMultiplier = 3, -- Apply to the update function "dt" parameter
    maxIndex = 0
}

function Frame:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Frame:update(dt)
    self.idx = self.idx + dt * self.dtMultiplier
    if self.idx < (0 + math.abs(dt * self.dtMultiplier)) or self.idx > (self.maxIndex + 1) then
        self.dtMultiplier = -self.dtMultiplier
    end
end

function Frame:generateByCountAndMax(count, max)
    frames = {}
    for i=1 , count do
        table.insert(frames, Frame:new({dtMultiplier = math.random(5), maxIndex = max}))
    end
    return frames
end

function Frame:generateByMaxValues(maxValues)
    frames = {}
    for i=1 , #maxValues do
        table.insert(frames, Frame:new({dtMultiplier = math.random(5), maxIndex = maxValues[i]}))
    end
    return frames
end

return Frame