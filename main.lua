local pixelA = require("pixelA")

local renderer

function love.load()
    renderer = pixelA.newRenderer("test1.pixela", 1)
end

function love.update(dt)
    renderer:update(dt)
end

function love.draw()
    renderer:draw(100, 100)
end