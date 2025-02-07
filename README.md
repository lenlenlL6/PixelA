# How it works ?
You write the code provided by PixelA in a .pixela file, which then processes the data to form each image into an animation. The code includes *width, height, color definition, selecting an area for coloring, etc*.

## ".pixela" file rules:
```
--[[
  The code below defines an animation that has a straight segment connecting from position (1, 1) to position (16, 16).
  Note that the code does not have a comment(--).
--]]

-- First, we have to set a fixed width and height for the animation.
2 16

--[[
  Next, we assign a color to any character you want.
  The syntax would be "c (character) (r, g, b)".
--]]
c * (1, 0, 0)
c g (0, 1, 0)


-- To start drawing the first frame, we have to start the drawing area with the letter "#".

-- Start drawing.
#
--[[
  Draw a line from (1, 1) to (16, 16) with *(color)
  You can also use rectangle(x, y, width, height, color) to draw a rectangle.
--]]
line (1, 1, 2, 16, *)
-- End drawing
#

#
line (1, 1, 2, 16, g)
#
```

Next, to be able to use it in Love2D, we use the following code:
```lua
local pixelA = require("pixelA")

local renderer

function love.load()
    --[[
        The second parameter is the interval between two frames in seconds.
        The third parameter will cause the animation to run immediately when the game starts if true, or vice versa if false.
    --]]
    renderer = pixelA.newRenderer("test1.pixela", 1, true)
end

function love.update(dt)
    renderer:update(dt)
end

function love.draw()
    renderer:draw(100, 100)
end
```

## A few functions for the Renderer:
```lua
Renderer:gotoFrame(frame)
```
This function adjusts the current frame of the animation and resets the *timer*.


```lua
Renderer:pause()
```
This function pause an animation, not reset the *timer*.


```lua
Renderer:continue()
```
This function continue an animation when its paused.

## Preview:
https://github.com/user-attachments/assets/8ba4f5e8-3032-4bdb-92bd-b738d9f6501f
