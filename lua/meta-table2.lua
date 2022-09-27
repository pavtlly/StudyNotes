-- __index 在访问表中一些不存在的字段时, 进行自定义操作
-- __index是一个函数
local mt1 = {}
mt1.__index = function(tb, k)
    print("元表中的index")
    print(tb, k)
end

local a = {99}
setmetatable(a, mt1)
print(a, mt1)
print(a[1], a[2])

-- __index是一个表
local mp1 = {name = "wc", age = 23}
local mt2 = {
    __index = mp1 -- index对应的表
}
local b = {sex = "boy"}
setmetatable(b, mt2)
-- print(b.sex, b.name, b.age, b.enjoy)

-- __index 表中内容带有函数
local mp2 = {
    name = "wc",
    age = 23,
    sayHello = function()
        print("hello")
    end,
    sayBye = function()
        print("bye")
    end
}

local mt3 = {
    __index = mp2
}
local c = {}
setmetatable(c, mt3)
print(c.name, c.age)
c.sayHello()
c.sayBye()

-- 库定义的元方法
local mt4 = {}
mt4.__tostring = function(tb)
    local str = ""
    for k, v in ipairs(tb) do
        str = str .. v
    end
    return str
end

mt4.__metatable = "not your business"
local d = {1, 2, 3}
print(d)
setmetatable(d, mt4)
print(d)

local mt5 = {}
local e = {}
setmetatable(e, mt5)

mt5.__index = function(tb, k)
    return k * k + 1
end

local p = {111, 222, 333}
mt5.__newindex = p
e[3] = 1111

print(e[3], p[3])

local f = setmetatable({}, {
    __call = function(t, a, b, c, d)
        return (a + b + c) * d;
    end
})
print(f(1, 2, 3, 4))

function readOnly(t)
    local proxy = {}
    local mt = {
        __index = t,
        __newindex = function (t, k, v)
            error("attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, mt)
    return proxy
end

days = readOnly{"sunday", "monday", "tuesday", "wednesday"}
print(days[1])
-- days[3] = "1111"

-- 忽略元表操作的rawget rawset

local mt1 = {
    name = "222"
}
local mt = {
    __index = mt1,
    __newindex = function()
        print("元表修改功能")
    end
}

local t = {}
setmetatable(t, mt)
print(t.name)
print(rawget(t, "name"))
t.name = "3333"
rawset(t, "name", "111")
print(t.name)
