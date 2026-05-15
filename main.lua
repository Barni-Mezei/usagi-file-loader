---@diagnostic disable: need-check-nil, cast-local-type, param-type-mismatch

require("lib.graphics")
require("lib.misc")

local ppm_loader = require("lib.ppm_loader")
local grid = require("lib.grid")

function _config()
	return {
		name = "Image loader",
		game_id = "com.barni-07.image-loaders",

		-- game_width = 640,
		-- game_height = 360,
	}
end

-- The image data grid
local image = {}

function _init()
	local err

	-- Load an image
	image, err = ppm_loader.load("test/sines.ascii.ppm")
	if err then print(err) usagi.quit() end

	-- Modify the image

	-- Rainbow edges
	-- image:foreach(function (x, y, value)
	-- 	local index = (x+y)%16 + 1
	-- 	return math.max(math.min(math.floor(index), 16), 1)
	-- end)

	-- Color shift
	image:foreach(function (x, y, value)
		local index = (value + x/100)%16 + 1
		return math.max(math.min(math.floor(index), 16), 1)
	end)


	-- Export the modified image
	err = ppm_loader.save(image, "test/out.ppm", true)
	if err then print(err) usagi.quit() end

	-- Load back the modified image and show it on screen
	image, err = ppm_loader.load("test/out.ppm")
	if err then print(err) usagi.quit() end
end

function _update(dt)
end

function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)

	local w = usagi.GAME_W * (0.75 + math.cos(usagi.elapsed) * 0.25)
	local h = usagi.GAME_H * (0.75 + math.sin(usagi.elapsed) * 0.25)

	gfx.render_grid(image, 0,0,  w,h)
end
