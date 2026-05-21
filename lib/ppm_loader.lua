--- This file allows you to load and save PPM files, both ascii and binary versions of it
--- Creator: barni-07 (https://github.com/Barni-Mezei)
--- Based on the following resources:
--- - https://en.wikipedia.org/wiki/Netpbm

--- Load dependencies
local grid = require("lib.grid")

--- @class PPM
--- @field palette table A table which holds colors. This palette is
--- used while loading a PPM image and converting it into palette indexes
local M = {
    -- Default Pico-8 palette
    palette = {
        {r = 0,   g = 0,   b = 0  },
        {r = 29,  g = 43,  b = 83 },
        {r = 126, g = 37,  b = 83 },
        {r = 0,   g = 135, b = 81 },
        {r = 171, g = 82,  b = 54 },
        {r = 95,  g = 87,  b = 79 },
        {r = 194, g = 195, b = 199},
        {r = 255, g = 241, b = 232},
        {r = 255, g = 0,   b = 77 },
        {r = 255, g = 163, b = 0  },
        {r = 255, g = 236, b = 39 },
        {r = 0,   g = 228, b = 54 },
        {r = 41,  g = 173, b = 255},
        {r = 131, g = 118, b = 156},
        {r = 255, g = 119, b = 168},
        {r = 255, g = 204, b = 170},
    }
}



---Snaps the provided RGB color to the nearest color
---in the palette.
---@param r number The RED channel (0 - 255)
---@param g number The GREEN channel (0 - 255)
---@param b number The BLUE channel (0 - 255)
---@return integer palette The palette index of the color in
---the `ppm_loader.palette` table, which is closest to the
---input color
function M.quantize_to_palette(r, g, b)
    local min_distance = math.huge
    local closest_index = 1

    -- Not the best algorithm, in terms of color accuracy
    for i, palette_color in ipairs(M.palette) do
        local distance = math.sqrt(
            (r - palette_color.r)^2 +
            (g - palette_color.g)^2 +
            (b - palette_color.b)^2
        )

        if distance < min_distance then
            min_distance = distance
            closest_index = i
        end
    end

    return closest_index
end



---Reads an ASCII coded PPM file
---@param file_handler file* The file to read
---@param width integer The width of the image (in pixels)
---@param height integer the height of the image (in pixels)
---@param color_res integer The color resolution of the image
---@return Grid.Grid|nil, string|nil pixels The pixel values in the image and an optional error message
local function _load_ascii_ppm(file_handler, width, height, color_res)
    -- Create color grid
    local out = grid.create_grid(width, height, gfx.COLOR_BLACK)

    for y = 1, height do
        for x = 1, width do
            local r = file_handler:read("n")
            local g = file_handler:read("n")
            local b = file_handler:read("n")

            if r == nil or g == nil or b == nil then
                return nil, "File has an invalid structure!"
            end

            local palette_index = M.quantize_to_palette(
                r/color_res*255,
                g/color_res*255,
                b/color_res*255
            )

            grid.set_cell(out, x, y, palette_index)
        end
    end

    return out, nil
end

---Reads a BINARY coded PPM file
---@param file_handler file* The file to read
---@param width integer The width of the image (in pixels)
---@param height integer the height of the image (in pixels)
---@return Grid.Grid|nil, string|nil pixels The pixel values in the image and an optional error message
local function _load_binary_ppm(file_handler, width, height)
    -- Create color grid
    local out = grid.create_grid(width, height, gfx.COLOR_BLACK)

    local _ = file_handler:read(1)

    for y = 1, height do
        for x = 1, width do
            local r = file_handler:read(1)
            local g = file_handler:read(1)
            local b = file_handler:read(1)

            if r == nil or g == nil or b == nil then
                return nil, "File has an invalid structure"
            end

            local palette_index = M.quantize_to_palette(
                string.unpack("B", r),
                string.unpack("B", g),
                string.unpack("B", b)
            )

            grid.set_cell(out, x, y, palette_index)
        end
    end

    return out
end

---Loads a PPM file from the disc and return a grid, containing renderable
---palette indexes
---@param path string The name of the file to load
---@return Grid.Grid|nil, string|nil image A 2D matrix of palette indexes
function M.load(path)
    local file, err = io.open(path, "r")

    if file == nil then
        return nil, err
    end

    local file_type = file:read(2)

    local line = ""
    local line_pos = 0

    while line == "" or string.sub(line, 1, 1) == "#" do
        line_pos = file:seek()
        line = file:read()
    end

    -- Jump to the first non-comment line
    file:seek("set", line_pos)

    -- Read image size
    local image_width = file:read("n")
    local image_height = file:read("n")
    local color_res = file:read("n")

    local out = {}

    if file_type == "P3" then
        ---@diagnostic disable-next-line: cast-local-type
        out, err = _load_ascii_ppm(file, image_width, image_height, color_res)
    elseif file_type == "P6" then
        -- No color_res passed in, since it is always 8-bit = 255
        ---@diagnostic disable-next-line: cast-local-type
        out, err = _load_binary_ppm(file, image_width, image_height)
    else
        err = "File is not in the correct format (P3 or P6)"
    end

    file:close()

    if err then err = string.format("%s: %s", path, err) end

    return out, err
end



---Saves an ASCII coded PPM file
---@param file_handler file* The file to save into
---@param pixel_grid Grid.Grid A 2D matrix of pixel values to save
---@return string|nil error An optional error message or nothing
local function _save_ascii_ppm(file_handler, pixel_grid)
    for y = 1, pixel_grid.height do
        for x = 1, pixel_grid.width do
            local palette_index = pixel_grid[y][x]
            local color = M.palette[palette_index]

            if color == nil then
                return string.format("The grid has invalid palette index at %d;%d", x, y)
            end

            -- Write pixel data
            local pixel_data = string.format("%3d %3d %3d", color.r, color.g, color.b)
            file_handler:write(pixel_data)

            -- Insert a new line after every 4 pixel (60chr)
            -- This step is needed top prevent
            -- going over the "70chr/line" limit
            file_handler:write(x % 5 == 0 and "\n" or " ")
        end
    end
end

---Saves a BINARY coded PPM file
---@param file_handler file* The file to save into
---@param pixel_grid Grid.Grid A 2D matrix of pixel values to save
---@return string|nil error An optional error message or nothing
local function _save_binary_ppm(file_handler, pixel_grid)
    for y = 1, pixel_grid.height do
        for x = 1, pixel_grid.width do
            local palette_index = pixel_grid[y][x]
            local color = M.palette[palette_index]

            if color == nil then
                return string.format("The grid has invalid palette index at %d;%d", x, y)
            end

            -- Write pixel data
            file_handler:write(string.pack("B", color.r))
            file_handler:write(string.pack("B", color.g))
            file_handler:write(string.pack("B", color.b))
        end
    end
end

---Saves a PPM image from the provided grid of palette indexes
---@param pixel_grid Grid.Grid A 2D matrix of pixel values, where each pixel
---value is a palette index from `M.palette`
---@param path string The path to the outputted file
---@param is_binary? boolean If this falg is set, then the image will be
---saved as a binary coded PPM image (`P6`)
---@return string|nil result Returns nil if the file creation was successful
---and returns an error message if it was not
function M.save(pixel_grid, path, is_binary)
    local binary_mode = is_binary or false

    if pixel_grid.width == nil or pixel_grid.height == nil then
        return "The grid is not a valid Grid.Grid"
    end

    -- Open the file
    local file, err
    if binary_mode then
        file, err = io.open(path, "wb")
    else
        file, err = io.open(path, "w")
    end

    if file == nil then return err end

    -- Create file header
    if binary_mode then
        file:write("P6\n")
    else
        file:write("P3\n")
    end

    -- Add watermark
    file:write("# Created with: 'Barni-07 - ppm_loader.lua'\n")

    -- Write the size
    file:write(string.format("%d %d\n", pixel_grid.width, pixel_grid.height))

    -- Write the color depth
    file:write("255\n")

    if binary_mode then
        err = _save_binary_ppm(file, pixel_grid)
    else
        err = _save_ascii_ppm(file, pixel_grid)
    end

    file:close()

    return err
end

return M
