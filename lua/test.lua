-- __index是一个表
local mp1 = {name = "wc", age = 23}
local mt2 = {
    __index = mp1 -- index对应的表
}
local b = {sex = "boy"}
setmetatable(b, mt2)
print(b.sex, b.name, b.age, b.enjoy)