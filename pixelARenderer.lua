local renderer = {}

function renderer:new(images, delay, playOnStart)
    local renderer = {}
    setmetatable(renderer, {__index = self})
    renderer.images = images
    renderer.index = 1
    renderer.delay = delay
    renderer.timer = delay

    renderer.state = playOnStart and "running" or "paused"
    return renderer
end

function renderer:update(dt)
    if self.state == "paused" then
        return
    end
    self.timer = self.timer - dt
    if self.timer <= 0 then
        self.index = (self.index == #self.images) and 1 or (self.index + 1)
        self.timer = self.delay
    end
end

function renderer:draw(x, y)
    love.graphics.draw(self.images[self.index], x, y, 0, 4, 4)
end

function renderer:gotoFrame(frame)
    self.index = frame
    self.timer = self.delay
end

function renderer:pause()
    self.state = "paused"
end

function renderer:continue()
    self.state = "running"
end

return renderer