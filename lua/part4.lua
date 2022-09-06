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
