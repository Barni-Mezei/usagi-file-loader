--- This file allows you to load MIDI files
--- Creator: barni-07 (https://github.com/Barni-Mezei)
--- Based on the following resources:
--- - https://midimusic.github.io/tech/midispec.html

--- @class MIDI
local M = {
    note_index_lookup = {
        {name = "C",  octave = 0, pitch = 0, freq = 0},
        {name = "C#", octave = 0, pitch = 0, freq = 0},
        {name = "D",  octave = 0, pitch = 0, freq = 0},
        {name = "D#", octave = 0, pitch = 0, freq = 0},
        {name = "E",  octave = 0, pitch = 0, freq = 0},
        {name = "F",  octave = 0, pitch = 0, freq = 0},
        {name = "F#", octave = 0, pitch = 0, freq = 0},
        {name = "G",  octave = 0, pitch = 0, freq = 0},
        {name = "G#", octave = 0, pitch = 0, freq = 0},
        {name = "A",  octave = 0, pitch = 0, freq = 0},
        {name = "A#", octave = 0, pitch = 0, freq = 0},
        {name = "B",  octave = 0, pitch = 0, freq = 0},

        {name = "C",  octave = 1, pitch = 0, freq = 0},
        {name = "C#", octave = 1, pitch = 0, freq = 0},
        {name = "D",  octave = 1, pitch = 0, freq = 0},
        {name = "D#", octave = 1, pitch = 0, freq = 0},
        {name = "E",  octave = 1, pitch = 0, freq = 0},
        {name = "F",  octave = 1, pitch = 0, freq = 0},
        {name = "F#", octave = 1, pitch = 0, freq = 0},
        {name = "G",  octave = 1, pitch = 0, freq = 0},
        {name = "G#", octave = 1, pitch = 0, freq = 0},
        {name = "A",  octave = 1, pitch = 0, freq = 0},
        {name = "A#", octave = 1, pitch = 0, freq = 0},
        {name = "B",  octave = 1, pitch = 0, freq = 0},

        {name = "C",  octave = 2, pitch = 0, freq = 0},
        {name = "C#", octave = 2, pitch = 0, freq = 0},
        {name = "D",  octave = 2, pitch = 0, freq = 0},
        {name = "D#", octave = 2, pitch = 0, freq = 0},
        {name = "E",  octave = 2, pitch = 0, freq = 0},
        {name = "F",  octave = 2, pitch = 0, freq = 0},
        {name = "F#", octave = 2, pitch = 0, freq = 0},
        {name = "G",  octave = 2, pitch = 0, freq = 0},
        {name = "G#", octave = 2, pitch = 0, freq = 0},
        {name = "A",  octave = 2, pitch = 0, freq = 0},
        {name = "A#", octave = 2, pitch = 0, freq = 0},
        {name = "B",  octave = 2, pitch = 0, freq = 0},

        {name = "C",  octave = 3, pitch = 0, freq = 0},
        {name = "C#", octave = 3, pitch = 0, freq = 0},
        {name = "D",  octave = 3, pitch = 0, freq = 0},
        {name = "D#", octave = 3, pitch = 0, freq = 0},
        {name = "E",  octave = 3, pitch = 0, freq = 0},
        {name = "F",  octave = 3, pitch = 0, freq = 0},
        {name = "F#", octave = 3, pitch = 0, freq = 0},
        {name = "G",  octave = 3, pitch = 0, freq = 0},
        {name = "G#", octave = 3, pitch = 0, freq = 0},
        {name = "A",  octave = 3, pitch = 0, freq = 0},
        {name = "A#", octave = 3, pitch = 0, freq = 0},
        {name = "B",  octave = 3, pitch = 0, freq = 0},

        {name = "C",  octave = 4, pitch = 0, freq = 0},
        {name = "C#", octave = 4, pitch = 0, freq = 0},
        {name = "D",  octave = 4, pitch = 0, freq = 0},
        {name = "D#", octave = 4, pitch = 0, freq = 0},
        {name = "E",  octave = 4, pitch = 0, freq = 0},
        {name = "F",  octave = 4, pitch = 0, freq = 0},
        {name = "F#", octave = 4, pitch = 0, freq = 0},
        {name = "G",  octave = 4, pitch = 0, freq = 0},
        {name = "G#", octave = 4, pitch = 0, freq = 0},
        {name = "A",  octave = 4, pitch = 0, freq = 0},
        {name = "A#", octave = 4, pitch = 0, freq = 0},
        {name = "B",  octave = 4, pitch = 0, freq = 0},

        {name = "C",  octave = 5, pitch = 0, freq = 0},
        {name = "C#", octave = 5, pitch = 0, freq = 0},
        {name = "D",  octave = 5, pitch = 0, freq = 0},
        {name = "D#", octave = 5, pitch = 0, freq = 0},
        {name = "E",  octave = 5, pitch = 0, freq = 0},
        {name = "F",  octave = 5, pitch = 0, freq = 0},
        {name = "F#", octave = 5, pitch = 0, freq = 0},
        {name = "G",  octave = 5, pitch = 0, freq = 0},
        {name = "G#", octave = 5, pitch = 0, freq = 0},
        {name = "A",  octave = 5, pitch = 0, freq = 0},
        {name = "A#", octave = 5, pitch = 0, freq = 0},
        {name = "B",  octave = 5, pitch = 0, freq = 0},

        {name = "C",  octave = 6, pitch = 0, freq = 0},
        {name = "C#", octave = 6, pitch = 0, freq = 0},
        {name = "D",  octave = 6, pitch = 0, freq = 0},
        {name = "D#", octave = 6, pitch = 0, freq = 0},
        {name = "E",  octave = 6, pitch = 0, freq = 0},
        {name = "F",  octave = 6, pitch = 0, freq = 0},
        {name = "F#", octave = 6, pitch = 0, freq = 0},
        {name = "G",  octave = 6, pitch = 0, freq = 0},
        {name = "G#", octave = 6, pitch = 0, freq = 0},
        {name = "A",  octave = 6, pitch = 0, freq = 0},
        {name = "A#", octave = 6, pitch = 0, freq = 0},
        {name = "B",  octave = 6, pitch = 0, freq = 0},

        {name = "C",  octave = 7, pitch = 0, freq = 0},
        {name = "C#", octave = 7, pitch = 0, freq = 0},
        {name = "D",  octave = 7, pitch = 0, freq = 0},
        {name = "D#", octave = 7, pitch = 0, freq = 0},
        {name = "E",  octave = 7, pitch = 0, freq = 0},
        {name = "F",  octave = 7, pitch = 0, freq = 0},
        {name = "F#", octave = 7, pitch = 0, freq = 0},
        {name = "G",  octave = 7, pitch = 0, freq = 0},
        {name = "G#", octave = 7, pitch = 0, freq = 0},
        {name = "A",  octave = 7, pitch = 0, freq = 0},
        {name = "A#", octave = 7, pitch = 0, freq = 0},
        {name = "B",  octave = 7, pitch = 0, freq = 0},

        {name = "C",  octave = 8, pitch = 0, freq = 0},
        {name = "C#", octave = 8, pitch = 0, freq = 0},
        {name = "D",  octave = 8, pitch = 0, freq = 0},
        {name = "D#", octave = 8, pitch = 0, freq = 0},
        {name = "E",  octave = 8, pitch = 0, freq = 0},
        {name = "F",  octave = 8, pitch = 0, freq = 0},
        {name = "F#", octave = 8, pitch = 0, freq = 0},
        {name = "G",  octave = 8, pitch = 0, freq = 0},
        {name = "G#", octave = 8, pitch = 0, freq = 0},
        {name = "A",  octave = 8, pitch = 0, freq = 0},
        {name = "A#", octave = 8, pitch = 0, freq = 0},
        {name = "B",  octave = 8, pitch = 0, freq = 0},

        {name = "C",  octave = 9, pitch = 0, freq = 0},
        {name = "C#", octave = 9, pitch = 0, freq = 0},
        {name = "D",  octave = 9, pitch = 0, freq = 0},
        {name = "D#", octave = 9, pitch = 0, freq = 0},
        {name = "E",  octave = 9, pitch = 0, freq = 0},
        {name = "F",  octave = 9, pitch = 0, freq = 0},
        {name = "F#", octave = 9, pitch = 0, freq = 0},
        {name = "G",  octave = 9, pitch = 0, freq = 0},
        {name = "G#", octave = 9, pitch = 0, freq = 0},
        {name = "A",  octave = 9, pitch = 0, freq = 0},
        {name = "A#", octave = 9, pitch = 0, freq = 0},
        {name = "B",  octave = 9, pitch = 0, freq = 0},

        {name = "C",  octave = 10, pitch = 0, freq = 0},
        {name = "C#", octave = 10, pitch = 0, freq = 0},
        {name = "D",  octave = 10, pitch = 0, freq = 0},
        {name = "D#", octave = 10, pitch = 0, freq = 0},
        {name = "E",  octave = 10, pitch = 0, freq = 0},
        {name = "F",  octave = 10, pitch = 0, freq = 0},
        {name = "F#", octave = 10, pitch = 0, freq = 0},
        {name = "G",  octave = 10, pitch = 0, freq = 0},
    }
}

local function _get_chunk_header(file_handler)
    local out = {
        type = "unknown",
        length = -1,
    }

    -- Determine chunk type
    local chunk_type = file_handler:read(4)

    if chunk_type == "MThd" then out.type = "header" end
    if chunk_type == "MTrk" then out.type = "track" end

    -- Determine chunk length
    out.length = string.unpack(">I4", file_handler:read(4))

    return out
end

local function _read_HEADER(file_handler)
    local out = {}

    out.format = string.unpack(">I2", file_handler:read(2))
    out.track_count = string.unpack(">I2", file_handler:read(2))

    local division = file_handler:read(2)

    -- Is in SMPTE format?
    if string.unpack(">I2", division) & 0x8000 > 0 then
        local low = string.unpack("B", division)
        local high = string.unpack("b", division)

        out.division = {
            mode = "smpte",
            frame = high, -- FPS
            tick = low, -- Tick / frame
        }
    else
        out.division = {
            mode = "tick",
            tick = string.unpack(">I2", division) -- Tick / 0.25 note
        }
    end

    return out
end

local function _read_TRACK(file_handler, chunk_data)
    local out = {}
    dump(chunk_data)

    return out
end


---Loads a MIDI file from the disc and returns a table, containing notes
---@param path string The path to the file to load
---@return table|nil, string|nil melody A table of notes
function M.load(path)
    local file, err = io.open(path, "r")

    if file == nil then
        return nil, err
    end

    local out = {
        bpm = 120,
        signature = {4, 4},
        track_count = -1,
        tracks = {},
    }

    local track_index = 0
    while out.track_count == -1 or track_index < out.track_count do
        local chunk_data = _get_chunk_header(file)

        if chunk_data.type == "header" then
            print("Header:")
            local header_data
            header_data, err = _read_HEADER(file)
            if err then err = string.format("%s: %s", path, err) break end

            out.format = header_data.format
            out.track_count = header_data.track_count
            out.division = header_data.division

            dump(header_data)
        end

        if chunk_data.type == "track" then
            print("Track:")
            local track_data
            track_data, err = _read_TRACK(file, chunk_data)
            if err then err = string.format("%s: %s", path, err) break end

            dump(track_data)

            table.insert(out.tracks, track_data)

            track_index = track_index + 1
        end
    end

    file:close()

    if err then err = string.format("%s: %s", path, err) end

    return out, err
end

return M
