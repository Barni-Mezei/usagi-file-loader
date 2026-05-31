---@diagnostic disable: need-check-nil, cast-local-type, param-type-mismatch

require("lib.misc")

local wav_loader = require("lib.wav_loader")

function _config()
	return {
		name = "Audio loader",
		game_id = "com.file-loader.image",

		-- game_width = 640,
		-- game_height = 360,
	}
end

-- The image data grid
local audio = {}

function _init()
	local err

	-- Load an image
	audio, err = wav_loader.load("test/wav/intro.wav")
	if err then print(err) usagi.quit() end
end

function _update(dt)
end

function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)
end
