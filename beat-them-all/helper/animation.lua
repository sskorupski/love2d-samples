Animation = {}

function Animation:buildQuads(image, count, startX, topY, frameXOffset, width, height)
    frames = {}
    for i = 1, count do
        table.insert(frames, love.graphics.newQuad(startX + frameXOffset * (i-1), topY, width, height, image:getWidth(), image:getHeight()))
    end
    return frames
end

return Animation