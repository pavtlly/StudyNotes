local List = {}

function List.new()
    return {first = 0, last = 0}
end

function List.pushFront(list, value)
    list.first = list.first - 1
    list[list.first] = value
end

function List.pushBack(list, value)
    list.last = list.last + 1
    list[list.last] = value
end

function List.popFront(list)
    if list.first >= list.last then
        error("List is empty")
    end
    local value = list[list.first]
    list[list.first] = nil
    list.first = list.first + 1
    return value
end

function List.popBack(list)
    if list.last <= list.first then
        error("List is empty")
    end
    local value = list[list.last]
    list[list.last] = nil
    list.last = list.last - 1
    return value
end

li = List.new()
List.pushBack(li, 17)
List.pushBack(li, -2)
List.pushFront(li, 33)
List.pushFront(li, 99)
local x = List.popBack(li)
print(x)
x = List.popFront(li)
print(x)
x = List.popBack(li)
print(x)