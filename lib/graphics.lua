---Same as `gfx.circ()` but it accepts a single table as a parameter, and an optional color
---If no color was provided it will attempt to get it from the table as well
function gfx.circ_t(circle, color) gfx.circ(circle.x, circle.y, circle.r, circle.color or color) end

---Same as `gfx.rect()` but it accepts a single table as a parameter, and an optional color
---If no color was provided it will attempt to get it from the table as well
function gfx.rect_t(rect, color) gfx.rect(rect.x, rect.y, rect.w, rect.h, rect.color or color) end

---Same as `gfx.rect_fill()` but it accepts a single table as a parameter, and an optional color
---If no color was provided it will attempt to get it from the table as well
function gfx.rect_fill_t(rect, color) gfx.rect_fill(rect.x, rect.y, rect.w, rect.h, rect.color or color) end

---Same as `gfx.line_t()` but it accepts two tables as two points, and an optional color
---If no color was provided it will attempt to get it from the first, then the second point table
function gfx.line_t(pointA, pointB, color) gfx.line(pointA.x, pointA.y, pointB.x, pointB.y, pointA.color or pointB.color or color) end

---Same as `gfx.rect()` but it draws the rectangle with a dotted line
function gfx.rect_dot(x, y, w, h, color)
    for dx = x, x + w, 2 do
        gfx.px(x + dx, y, color)
        gfx.px(x + dx, y + h, color)
    end

    for dy = y, y + h, 2 do
        gfx.px(x, y + dy, color)
        gfx.px(x + w,y + dy, color)
    end
end

---Renders a 2D matrix of palette indexes on to the screen
---For rendering images in a smaller size, it uses `nearest neighbour` sampling
---@param grid table An 2D matrix of pixel values (Should be a table,
---containing rows, which are also tables containing pixel values. Pixel values
---are palette indexes)
---@param x number The X coordinate of the top-left corner of the image
---@param y number The Y coordinate of the top-left corner of the image
---@param w number The total wodth of the image
---@param h number The total wodth of the image
function gfx.render_grid(grid, x, y, w, h)
    -- Render placeholder rectangle
    if grid == nil then
        gfx.rect(x, y, w, h, gfx.COLOR_RED)
        return
    end

    local step_x = 1
    local step_y = 1
    local scale_x = 1
    local scale_y = 1

    -- X
    if grid.width < w then
        scale_x = w / grid.width
    end

    if grid.width > w then
        step_x = grid.width / w
    end

    -- Y
    if grid.height < h then
        scale_y = h / grid.height
    end

    if grid.height > h then
        step_y = grid.height / h
    end

    for py = 0, grid.height-1, step_y do
        for px = 0, grid.width-1, step_x do
            gfx.rect_fill(x + (px / step_x)*scale_x, y + (py / step_y)*scale_y, math.ceil(scale_x), math.ceil(scale_y), grid[math.floor(py+1)][math.floor(px+1)])
            -- if scale_x == 1 and scale_y == 1 then
            --     gfx.pixel(x + px*w*scale_x, y + py*h*scale_y, grid[math.floor(py)][math.floor(px)])
            -- else
            --     gfx.rect_fill(x + px*w*scale_x, y + py*h*scale_y, w*scale_x, h*scale_y, grid[math.floor(py)][math.floor(px)])
            -- end
        end
    end
end