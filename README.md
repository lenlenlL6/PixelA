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
