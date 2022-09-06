package.path = package.path ..';..\\?.lua';
require "functions"

FuzzyVariable = class("FuzzyVariable")

function FuzzyVariable:addMemberTriangular(state1, x0, state2, x2, state3)
	self.x0 = x0
	self.x1 = (x0 + x2) / 2
	self.x2 = x2
	self.state1 = state1
	self.state2 = state2
	self.state3 = state3
end

function FuzzyVariable:input(value)
	self.value = value
	if self.membershipDegree == nil then self.membershipDegree = {} end
	self.membershipDegree[self.state1] = self:fuzzyReverseGrade()
	self.membershipDegree[self.state2] = self:fuzzyTriangle()
	self.membershipDegree[self.state3] = self:fuzzyGrade()
end

function FuzzyVariable:printResult()
	local res = ""
	for k, v in pairs(self.membershipDegree) do
		res = res .. k .. "  " .. v .. "    "
	end
	print(res)
end

-- 获取每种状态归属度值
function FuzzyVariable:getMembershipDegree(state)
	return self.membershipDegree[state]
end

-- 右肩归属函数
function FuzzyVariable:fuzzyReverseGrade()
	result = 0
	x = self.value
	if x <= self.x0 then 
		result = 1
	elseif x >= self.x1 then
		result = 0
	else
		result = (-x / (self.x1 - self.x0)) + (self.x1 / (self.x1 - self.x0))
	end
	return result
end

-- 三角归属函数
function FuzzyVariable:fuzzyTriangle()
	result = 0
	x = self.value
	if x <= self.x0 then
		result = 0
	elseif x == self.x1 then
		result = 1
	elseif (x > self.x0) and (x < self.x1) then
		result = (x / (self.x1 - self.x0)) - (self.x0 / (self.x1 - self.x0))
	else
		result = (-x / (self.x2 - self.x1)) + (self.x2 / (self.x2 - self.x1))
	end
	return result
end

-- 左肩归属函数
function FuzzyVariable:fuzzyGrade()
	result = 0
	x = self.value
	if x <= self.x0 then 
		result = 0
	elseif x >= self.x1 then
		result = 1
	else
		result = (x / (self.x1 - self.x0))- (self.x0 / (self.x1 - self.x0))
	end
	return result
end