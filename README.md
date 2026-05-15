This is a simple PPM image manager class. The manager is in the [ppm_loader.lua](lib/ppm_loader.lua) file and it has a single dependency: [grid.lua](lib/grid.lua). For easy rendering, it is recommended to use the [graphics.lua](lib/graphics.lua) -> `render_grid()` function.

Made with (and for) the [Usagi](https://github.com/brettchalupa/usagi) engine

# Using the loader

First, you need to place the `ppm_loader.lua` and `grid.lua` files into your project. Next, you need to update the path to the `grid.lua` file at the beggining of the `ppm_loader.lua` file. And, that's it! You can now load and render PPM files directly.

Example for loading and rendering a PPM image
```lua
-- Load the PPM loader
local ppm_loader = require("lib.ppm_loader")

-- Load graphics.lua for rendering grids (loaded images)
require("lib.graphics")

-- The image data grid
local image = {}



function _init()
	-- Load a PPM image
	local err
	image, err = ppm_loader.load("test/sines.ascii.ppm")

    if err then
        print(err)
        usagi.quit()
    end
end



function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)

    -- Render the loaded image in full screen
	gfx.render_grid(image, 0,0, usagi.GAME_W, usagi.GAME_H)
end
```

# About the loader

The loader supports PPM images, both in ASCII (P3) and in BINARY (P6) formats.

After loading a PPM image the loader needs to convert the RGB colors into palette indexes. This is done based on the `ppm_loader.palette` table. In this table, each item is another table with an `r`, `g` and `b` fields (each one is from 0 to 255). If you are using a custom palette, then you will need to update this palette as well.

# Methods

## `load()`

### *NOTE: Calling this function, will load an entire image into memory!*

### Arguments
- `path` (**string**): Path to a PPM file (the file extension does not matter, the file content does.)

### Returns
- `Grid.Grid`: A 2D matrix (table of tables, where each sub table is a row in the image) of palette indexes from `ppm_loader.palette`.

### Example

```lua
-- Loads the 2D matrix into image and the
-- occasional error message into err
local image, err = ppm_loader.load("test.ppm")

if err then
    print(err)
    usagi.quit()
end
```



## `save()`

### Arguments
- `pixel_grid` (**Grid.Grid**): A 2D matrix of palette indexes
- `path` (**string**): Path to save the new PPM file to
- `is_binary?` (**boolean**): If this is true, then the image will be saved as a binary coded PPM image, type `P6` instead of `P3`

### Returns
- `string|nil`: Returns `nil` if the file creation was successful and returns an error message if it was not

### Example

```lua
-- Creates a 5 by 5 grid, filled with the palette index of RED
local image = grid.create_grid(5, 5, gfx.COLOR_RED)

-- Saves the image
local err = ppm_loader.save(image, "red.ppm", true)

if err then
    print(err)
    usagi.quit()
end
```
