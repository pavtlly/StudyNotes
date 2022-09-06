-- 1. 递归 斐波那契数列
function fib(x)
    if x == 1 or x == 2 then
        return 1
    end
    return fib(x - 1) + fib(x - 2)
end
print(fib(10))

-- 2. vararg syntax 可变长参数
function fun(...)
    local tb = {...}
    local sum = 0
    for _, v in pairs(tb) do
        sum = sum + v
    end
    return sum
end
print(fun(1,2,2,3))

-- 3. lua 将值false和nil视为假; 在条件判断中将数字零和空字符串视为真
local a = nil
local b = false
local c = 0
if a or b then
    print("YES")
else
    print("NO")
end

-- 4. lua字符串是不可变值, 不能像C语言那样直接修改字符串中某个字符
-- 而是应该根据修改要求来创建一个新的字符串
local a = "one string"
b = string.gsub(a, "one", "another")
print(a, b)

-- 5. lua提供运行时的数字和字符串之间的自动转换 tostring tonumber
print(20 .. 21, tonumber("0521"))

-- 6. table通过"构造表达式" 创建, 最简单的构造表达式{}
local tb1 = {}
tb1["x"] = 1
tb1[1] = 2
local tb2 = tb1
print(tb1["x"], tb1[1])
tb2["x"] = tb2["x"] + 999
tb2[2] = 365
print(tb2["x"], tb2[1], tb2[2])

-- 7. lua对于a["name"]的写法一种更为简便的语法糖 a.name
local stu = {}
stu.name = "pavtlly"
print(stu["name"], stu.name)

-- 8. lua中 函数是作为"第一类值"  可以存储在变量中
-- 可以通过参数传递给其他函数 还可以作为其他函数的返回值

-- 9. 对于table、userdata和函数 lua是做引用比较的
-- 也就是说当它们引用同一个对象时 才认为是相等的
a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a
print(a == b, a == c)

-- 10. and 和 or 都使用"短路求值"
-- a and b or c 相当于C语言中 a ? b : c

-- 11. 构造式是用来创建和初始化table的表达式
-- 数组形式
local nums = {12, 13, 14, 15, 16}
-- 结构体形式
local node2 = {x = 9, y = 11}
local node1 = {}; node1.x = 1; node1.y = 2

-- 12. unpack的一项重要用途体现在 "泛型调用"机制中
-- 泛型调用机制可以动态的以任何实参来调用任何函数
-- unpack lua中递归实现

local nums = {1115, 1023}
function add(a, b)
    return a + b
end
print(add(table.unpack(nums)))

function unpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], unpack(t, i + 1)
    end
end

-- 13. 函数构造式  匿名函数
local students = {
    {score = 88, name = "s1"},
    {score = 99, name = "s2"},
    {score = 95, name = "s3"}
}
table.sort(students, function (a, b) return a.score > b.score end)

for k, v in ipairs(students) do
    print(v.name, v.score)
end

-- 14. 函数遵循词法定界
function newCounter()
    local count = 0
    return function()
        count = count + 1
        print(count)
    end
end

-- c1 c2 开创了两份不同的闭包, 它们虽然建立在相同函数的基础上,
-- 但是拥有不同的局部变量count, 所以最终出来的结果间互不干扰
c1 = newCounter()
c1()
c1()
c2 = newCounter()
c2()
c1()
c2()


function create(n)
    local function foo1()
        print(n)
    end
    local function foo2()
        n = n + 10
    end
    return foo1, foo2
end

f1, f2 = create(1115)
f1()
f2()
f1()

-- 15. 迭代器
function values(t)
    local i = 0
    return function() i = i + 1; return t[i] end
end

local tb = {"year", 1997}
for element in values(tb) do
    print(element)
end

-- 16. 以协同程序实现迭代器 全排列
function printResult(b)
    local result = ""
    for i = 1, #b do
        result = result .. " " .. b[i]
    end
    print(result)
end

function permute(a, k)
    local n = #a
    if k == n then
        printResult(a)
    end
    for i = k, n do
        a[i], a[k] = a[k], a[i]
        permute(a, k + 1)
        a[i], a[k] = a[k], a[i]
    end
end

permute({1, 2, 3}, 1)

-- 17. 马尔科夫链

-- 函数 多重返回值
function func1()
    return "a", "b"
end
function func2()
    return "k"
end
print(func1())  -- a  b
print(func1() .. "x")  -- ax
print((func1()))  -- a  返回套一层括号 只返回一个值
t = {func1()}  -- t = {"a", "b"}
t = {func1(), func2()}  -- t = {"a", "k"}

-- lua中最常见的函数编写方式(语法糖)
function foo(x)
	return 2 * x
end

-- 是以下代码的一种简化书写形式
foo = function (x)
	return 2 * x
end

-- 函数构造式 结果称为匿名函数
-- function(x) <body> end

lib = {}
lib.foo = function(x, y) return x + y end
lib.goo = function(x, y) return x - y end

lib2 = {
	foo = function(x, y) return x + y end,
	goo = function(x, y) return x - y end
}

print(lib2.foo(1,2), lib2.goo(1, 2))