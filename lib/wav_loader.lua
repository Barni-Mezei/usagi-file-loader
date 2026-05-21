--- This file allows you to load WAV files
--- Creator: barni-07 (https://github.com/Barni-Mezei)
--- Based on the following resources:
--- - https://en.wikipedia.org/wiki/WAV
--- - https://en.wikipedia.org/wiki/Pulse-code_modulation
--- - https://nexkits.com/en/tools/audio-wav-inspect
--- - https://soniqtools.com/waveform

--- @class WAV
local M = {}

---Loads a WAV file from the disc and returns a table, containing playable
---sfx pitches
---@param path string The path to the file to load
---@return table|nil, string|nil audio A table of pitches
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
