local cwd = (...):gsub("pixelA", "")

local renderer = require(cwd .. "pixelARenderer")

local pixel = {}

function pixel.newRenderer(file, delay)
    local width, height
    
    local color = {}

    local startReadData = false

    local imageData
    local imageDataL = {}
    for line in io.lines("./" .. file) do
        if line == "" then
            goto continue
        end

        local data = {}
        for v in line:gmatch("[^ ,()]+") do
            table.insert(data, tonumber(v) and tonumber(v) or v)
        end
        if not width then
            width, height = data[1], data[2]
            imageData = love.image.newImageData(width, height)
            goto continue
        end
        if data[1] == "c" then
            color[data[2]] = {data[3], data[4], data[5]}
            goto continue
        end
        if startReadData and data[1] ~= "#" then
            if data[1] == "rectangle" then
                for y = data[3] - 1, data[5] - 1 do
                    for x = data[2] - 1, data[4] - 1 do
                        imageData:setPixel(x, y, color[data[6]])
                    end
                end
            end
            if data[1] == "line" then
                local x1, y1, x2, y2 = data[2], data[3], data[4], data[5]
                local dx = math.abs(x2 - x1)
                local dy = math.abs(y2 - y1)
                local sx = x1 < x2 and 1 or -1
                local sy = y1 < y2 and 1 or -1
                local err = dx - dy
                while true do
                    imageData:setPixel(x1 - 1, y1 - 1, unpack(color[data[6]]))
                    if x1 == x2 and y1 == y2 then
                        break
                    end
                    local e2 = 2 * err
                    if e2 > -dy then
                        err = err - dy
                        x1 = x1 + sx
                    end
                    if e2 < dx then
                        err = err + dx
                        y1 = y1 + sy
                    end
                end
            end
        end
        if data[1] == "#" then
            startReadData = not startReadData
            if not startReadData then
                table.insert(imageDataL, love.graphics.newImage(imageData))
            end
            goto continue
        end
        ::continue::
    end
    return renderer:new(imageDataL, delay)
end

return pixel
