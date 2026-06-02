---@diagnostic disable: need-check-nil, cast-local-type, param-type-mismatch

require("lib.misc")

local midi_loader = require("lib.midi_loader")

function _config()
	return {
		name = "Midi loader",
		game_id = "com.file-loader.audio",

		-- game_width = 640,
		-- game_height = 360,
	}
end

-- The image data grid
local melody = {}

function _init()
	local err

	-- Load an image
	melody, err = midi_loader.load("test/midi/super_mario_bros_theme.mid")
	if err then print(err) usagi.quit() end

	print("\nMelody:")
    dump(melody)
    os.exit()
end

function _update(dt)
end

function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)
end
