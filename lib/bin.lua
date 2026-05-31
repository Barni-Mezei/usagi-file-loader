---@diagnostic disable: undefined-field

---@class Bin
---This module provides useful helper functions for managing binary files, and binary numbers
local M = {}

---Big to little endian
---Converts the provided number from big to little endian
---@param num integer
---@return integer num A single number
function M.btl_endian(num)
    return num
end

return M
