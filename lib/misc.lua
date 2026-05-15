-- Alias for string formatting
f = string.format

---Prints the provided value to the console, using formatting
---@param value any The value to print to the console
---@param advanced? boolean if this flag is set, then functions, threads and user data wil be shown as well.
---@param max_depth? integer The maximum allowed depth
---@param depth? integer The current depth in the printing process
function dump(value, advanced, max_depth, depth)
	local a = advanced or false
	local d = depth or 1
	local md = max_depth or 10
	local t = tostring(value)

	if type(value) == "nil" then io.write("\27[90mnil\27[m") end
	if type(value) == "number" then io.write(f("\27[36m%.4f\27[m", t)) end
	if type(value) == "string" then io.write(f("\27[33m\"%s\"\27[m", t)) end
	if type(value) == "boolean" then io.write(f("%s\27[m", value and "\27[32mtrue" or "\27[31mfalse")) end
	if type(value) == "function" then io.write(f("\27[90m%s()\27[m", t)) end
	if type(value) == "userdata" then io.write(f("\27[90m%s()\27[m", t)) end
	if type(value) == "thread" then io.write(f("\27[90m%s()\27[m", t)) end
	if type(value) == "table" then
		-- Do not go deeper than the max allowed depth
		if d > md then
			io.write("{ \27[35m...\27[m }")
			return
		end

		local indent = string.rep("    ", d)
		local indent_small = string.rep("    ", d - 1)

		-- Empty table
		if next(value) == nil then
			io.write("{}")
		else
			io.write("{\n")
			for k, v in pairs(value) do
				-- Skip advanced data types if the advanced flag is set to false
				if (type(v) == "function" or type(v) == "userdata" or type(v) == "thread") and not a then
					goto continue_dump_loop
				end

				if type(k) == "number" then
					io.write(f("%s\27[36m#%s\27[m = ", indent, tostring(k)))
				else
					io.write(indent..tostring(k).." = ")
				end

				dump(v, a, md, d + 1)

				io.write(",\n")

				::continue_dump_loop::
			end
			io.write(indent_small.."}")
		end
	end

	if d == 1 then io.write("\n") end
end
