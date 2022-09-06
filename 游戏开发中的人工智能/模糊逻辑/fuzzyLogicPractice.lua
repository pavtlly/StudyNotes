package.path = package.path ..';..\\?.lua';
require "fuzzyVariable"
require "fuzzySet"

local hp = FuzzyVariable.new("hp")
hp:addMemberTriangular("less", 500, "equal", 1000, "more")

local skill = FuzzyVariable.new("skill")
skill:addMemberTriangular("none", 1, "cd", 7, "ready")

local level = FuzzyVariable.new("level")
level:addMemberTriangular("less", -2, "equal", 2, "more")

local targetS = FuzzySet.new("targetStrong")
targetS:addVar(hp, "hp")
targetS:addVar(skill, "skill")
targetS:addVar(level, "level")

-- 数据输入
hp:input(1000)
skill:input(2)
level:input(1)

-- 模糊规则
targetS:addRule("strong", "hp.more and level.more and skill.cd")
targetS:addRule("normal", "(not hp.less) and (not level.less) and (not skill.none)")
targetS:addRule("weak", "hp.less or level.less or skill.none")

-- 练习一 实现模糊变量的归属度计算
hp:printResult()
skill:printResult()
level:printResult()

-- 练习二 实现模糊规则和反模糊化输出
targetS:printResult()
print(targetS:defuzzy("Max"))
print(targetS:defuzzy("WeightSum", {strong = 100, normal = 50, weak = 10}))