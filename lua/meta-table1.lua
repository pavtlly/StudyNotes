-- 1. 深搜 n(5)个顶点 m(5)条边
local mp = {}
local vis = {}
local pre = {}

mp[1] = {}
mp[2] = {}
mp[3] = {}
mp[4] = {}
mp[5] = {}
table.insert(mp[1], 2)
table.insert(mp[2], 3)
table.insert(mp[2], 4)
table.insert(mp[3], 5)
table.insert(mp[5], 2)

local isOk = false

function dfs(x)
    if x == 5 then isOk = true end
    for k = 1, #mp[x] do
        local y = mp[x][k]
        if not vis[y] then
            vis[y] = true
            pre[y] = x
            dfs(y)
            vis[y] = false
        end
    end
end

function path(d, str)
    if not d then
        print(str)
        return
    end
    if str == "" then
        str = tostring(d)
    else
       str = tostring(d) .. " -> " .. str
    end
    path(pre[d], str)
end

dfs(1)
if isOk then print("YES")
else print("NO") end

path(5, "")

-- 2. 元表和元方法
t = {11, 22, 33, 44}
t1 = {55, 66, 77, 88}
setmetatable(t, t1)
print(getmetatable(t) == t1)

Set = {}
-- function Set.new(l)
--     local set = {}
--     for _, v in ipairs(l) do
--         set[v] = true
--     end
--     return set
-- end

function Set.union(a, b)
    local res = Set.new{}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end

function Set.intersection(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.tostring(set)
    -- 用于存放集合中所有元素的列表
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ",") .. "}"
end

function Set.print(s)
    print(Set.tostring(s))
end

-- 开始操作
local mt = {}
function Set.new(l)
    local set = {}
    setmetatable(set, mt)
    for _, v in ipairs(l) do
        set[v] = true
    end
    return set
end

s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
print(getmetatable(s1))
print(getmetatable(s2))

Set.print(s1)
Set.print(s2)

-- 算术类元方法
mt.__add = Set.union
Set.print(s1 + s2)

mt.__mul = Set.intersection
Set.print((s1 + s2) * s1)

-- __sub(减法)  __div(除法)  __unm(相反数)
-- __mod(取模)  __pow(乘幂)  __concat(连接操作符)

s = Set.new{1, 2, 3}
Set.print(s + {8})

-- 关系类元方法
-- __ep(等于)  __lt(小于)  __le(小于等于)
mt.__le = function (a, b)
    for k in pairs(a) do
        if not b[k] then return false end
    end
    return true
end

mt.__eq = function (a, b)
    return a <= b and a >= b
end

mt.__lt = function (a, b)
    return a <= b and not (b <= a)
end

s11 = Set.new{2, 4}
s22 = Set.new{4, 10, 2}
print(s11 <= s22)
print(s11 < s22)
print(s11 >= s11)
print(s11 > s11)
print(s11 == s22 * s11)

-- -- 定义一个table
-- local tb = {
-- 	66,
-- 	11,
-- 	h = 25,
-- 	w = 32
-- }

-- -- 定义元表
-- local mt = {x = 77, y = 78, h = 9}

-- -- 打印没有元表的情况
-- print("no metatable tb.h =", tb.h)
-- print("no metatable tb.x =", tb.x)

-- -- 设置元表
-- setmetatable(tb, {__index = mt})

-- -- 打印有元表的情况
-- print("have metatable tb.h =", tb.h)
-- print("have metatable tb.x =", tb.x)

-- -- 打印不使用元表的情况
-- print("not use metatable tb.h =", rawget(tb, "h"))
-- print("not use metatable tb.x =", rawget(tb, "x"))

-- 元表 元方法 运算符重载
local mt1 = {}
mt1.__add = function(a, b)
	if type(a) ~= "table" or type(b) ~= "table" or #a ~= #b then
		return {}
	end
	local tb = {}
	for k, v in ipairs(a) do
		tb[k] = a[k] + b[k]
	end
	return tb
end

local mt2 = {}
mt2.__add = function(a, b)
	if type(a) ~= "table" or type(b) ~= "table" or #a ~= #b then
		return {}
	end
	local tb = {}
	for k, v in ipairs(a) do
		tb[k] = a[k] + 2 * b[k]
	end
	return tb
end

local a = {1, 2}
local b = {3, 5}

setmetatable(a, mt1)
setmetatable(b, mt2)

c = a + b
-- for k, v in ipairs(a) do
-- 	print(k, v)
-- end

-- for k, v in ipairs(b) do
-- 	print(k, v)
-- end

-- for k, v in ipairs(c) do
-- 	print(k, v)
-- end

local mt3 = {}
mt3.__eq = function(a, b)
	if type(a) ~= "table" or type(b) ~= "table" or #a ~= #b then
		return false
	end
	table.sort(a)
	table.sort(b)
	for k, v in ipairs(a) do
		print("mt3", a[k], b[k])
		if a[k] ~= b[k] then return false end
	end
	return true
end

local mt4 = {}
mt4.__eq = function(a, b)
	if type(a) ~= "table" or type(b) ~= "table" or #a ~= #b then
		return false
	end
	for k, v in ipairs(a) do
		print("mt4", a[k], b[k])
		if a[k] ~= b[k] then return false end
	end
	return true
end

local e = {1, 2, 3}
local f = {1, 2, 3}
setmetatable(e, mt4)
setmetatable(f, mt4)

print(e == f)