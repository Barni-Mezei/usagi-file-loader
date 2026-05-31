--- This file allows you to load MIDI files
--- Creator: barni-07 (https://github.com/Barni-Mezei)
--- Based on the following resources:
--- - https://midimusic.github.io/tech/midispec.html

--- @class MIDI
local M = {}

---Loads a MIDI file from the disc and returns a table, containing notes
---@param path string The path to the file to load
---@return table|nil, string|nil melody A table of notes
function M.load(path)
    local file, err = io.open(path, "r")

    if file == nil then
        return nil, err
    end

    local out = {}

    file:close()

    if err then err = string.format("%s: %s", path, err) end

    return out, err
end

return M
