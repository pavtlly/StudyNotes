--[[

Copyright (c) 2014-2017 Chukong Technologies Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]

lua_type = type
lua_tostring = tostring
local strsub = string.sub

local setmetatableindex_
setmetatableindex_ = function(t, index)
	if lua_type(t) == "userdata" then
		local peer = tolua.getpeer(t)
		if not peer then
			peer = {}
			tolua.setpeer(t, peer)
		end
		setmetatableindex_(peer, index)
	else
		local mt = getmetatable(t)
		if not mt then
			-- if mt is nil, and index is table
			-- mt(t) = index ~ mt(t).__index = index
			if lua_type(index) == "table" and rawget(index, "__index") == index then
				setmetatable(t, index)
				return
			end
			mt = {}
		end
		-- mt will be DIRTY!!!
		if not mt.__index then
			mt.__index = index
			setmetatable(t, mt)
		elseif mt.__index ~= index then
			setmetatableindex_(mt, index)
		end
	end
end
setmetatableindex = setmetatableindex_

function class(classname, ...)
	local cls = {
		__cname = classname,
		-- __tostring = tostring_func,
		-- pairs = pairs_func,
		-- rawset = rawset_func,
		-- rawget = rawget_func,
	}

	local supers = {...}
	for _, super in ipairs(supers) do
		local superType = lua_type(super)
		assert(superType == "nil" or superType == "table" or superType == "function",
			format("class() - create class \"%s\" with invalid super class type \"%s\"",
				classname, superType))

		if superType == "function" then
			assert(cls.__create == nil,
				format("class() - create class \"%s\" with more than one creating function",
					classname));
			-- if super is function, set it to __create
			cls.__create = super
		elseif superType == "table" then
			if super[".isclass"] then
				-- super is native class
				assert(cls.__create == nil,
					format("class() - create class \"%s\" with more than one creating function or native class",
						classname));
				cls.__create = function() return super:create() end
			else
				-- super is pure lua class
				cls.__supers = cls.__supers or {}
				cls.__supers[#cls.__supers + 1] = super
				if not cls.__super then
					-- set first super pure lua class as class.super
					cls.__super = super
				end
			end
		else
			error(format("class() - create class \"%s\" with invalid super type",
						classname), 0)
		end
	end

	cls.__index = cls
	if not cls.__supers or #cls.__supers == 1 then
		setmetatable(cls, {__index = cls.__super})
	else
		printWarn("dont use multiple supers !")
		setmetatable(cls, {__index = function(_, key)
			local supers = cls.__supers
			for i = 1, #supers do
				local super = supers[i]
				if super[key] then return super[key] end
			end
		end})
	end

	-- -- like c++ constructor
	-- if not cls.ctor then
	-- 	-- add default constructor
	-- 	cls.ctor = function(...)
	-- 		if cls.__super then
	-- 			return cls.__super.ctor(...)
	-- 		end
	-- 	end
	-- end
	cls.new = function(...)
		local instance
		if cls.__create then
			-- create when superType is function or [.isclass]
			instance = cls.__create(...)
		else
			instance = {}
		end
		local ty = lua_type(instance)
		instance.__cid = tonumber(strsub(lua_tostring(instance), #ty+2), 16)
		instance.__class = cls
		setmetatableindex_(instance, cls)
		-- no super.ctor like python __init__
		local ctor = instance.ctor
		if ctor then
			ctor(instance, ...)
		end
		-- do
		-- 	-- create like c++ constructor
		-- 	local create
		-- 	create = function(c, ...)
		-- 		if rawget(c, "__super") then
		-- 			create(c.__super, ...)
		-- 		end
		-- 		if rawget(c, "ctor") then
		-- 			c.ctor(instance, ...)
		-- 		end
		-- 	end
		-- 	create(cls, ...)
		-- end
		return instance
	end
	-- like native's create export function
	cls.create = function(_, ...)
		return cls.new(...)
	end

	return cls
end

function fuzzyAnd(a, b)
	return math.min(a, b)
end

function fuzzyOr(a, b)
	return math.max(a, b)
end

function fuzzyNot(a)
	return 1 - a
end