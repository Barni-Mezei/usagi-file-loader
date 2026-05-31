---@diagnostic disable: need-check-nil, cast-local-type, param-type-mismatch, undefined-field

require("lib.misc")

local midi_loader = require("lib.midi_loader")

local p = 1

local n = 1 / 12

local A = 1 + n*6
local B = 1 + n*7
local C = 1 + 0
local D = 1 + n
local E = 1 + n*2
local F = 1 + n*3
local G = 1 + n*4
local H = 1 + n*5

local music = {
    A,
    E,
    A,
    E,
    D,
    F,
    D,
    F,
}

local pointer = -1

local time = 0
local note_time = 0.25

function _update(dt)
    time = time + dt

    if pointer ~= -1 then
        if time >= note_time then
            pointer = pointer + 1
            time = 0
        end

        sfx.play_ex("bass", 1, music[pointer], 0)

        if pointer > #music then pointer = 1 end
    end

    if input.pressed(input.LEFT) then
        pointer = 1
    end
end

function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)

    gfx.text(tostring(pointer), 0, 0, gfx.COLOR_WHITE)
end
