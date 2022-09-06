package.path = package.path ..';..\\?.lua';
require "functions"
require "fuzzyVariable"

FuzzySet = class("FuzzySet")

function FuzzySet:addVar(var, varName)
	if self.vars == nil then self.vars = {} end
	self.vars[varName] = var
end

-- 字符串拆分
function FuzzySet:ruleDeal(rule)
	-- 取字符
	local vars = {}
	local extents = {}
	local relation = {}
	for i = 1, #rule do
		local c1 = rule.sub(rule, i, i)
		if c1 == '.' then
			for j = i, 1, -1 do
				local c2 = rule.sub(rule, j, j)
				if c2 == ' ' or j == 1 then
					if j ~= 1 then j = j + 1 end
					local str = rule.sub(rule, j, i - 1)
					table.insert(vars, str)
					break
				end
			end

			for j = i, #rule, 1 do
				local c3 = rule.sub(rule, j, j)
				if c3 == ' ' or j == #rule then
					if j == #rule then j = j + 1 end
					local str = rule.sub(rule, i + 1, j - 1)
					table.insert(extents, str)
					break
				end
			end
		end
		if c1 == 'r' then
			local s = rule.sub(rule, i - 1, i)
			if s == "or" then table.insert(relation, s) end
		elseif c1 == 'd' then
			local s = rule.sub(rule, i - 2, i)
			if s == "and" then table.insert(relation, s) end
		end

	end
	-- local res1 = ""
	-- local res2 = ""
	-- for k = 1, #vars do
	-- 	res1 = res1 .. vars[k] .. "  "
	-- end
	-- for k = 1, #extents do
	-- 	res2 = res2 .. extents[k] .. "  "
	-- end
	-- print(res1)
	-- print(res2)

	local result
	for i = 1, (#vars - 1) do
		local value1, value2
		local var1, var2, extent
		for k, v in pairs(self.vars) do
			if vars[i] == k then var1 = v end
			if vars[i + 1] == k then var2 = v end
		end
		local c = extents[i].sub(extents[i], #extents[i], #extents[i])
		if c == ')' then
			extent = extents[i].sub(extents[i], 1, #extents[i] - 1)
			value1 = 1 - var1:getMembershipDegree(extent)
		else
			value1 = var1:getMembershipDegree(extents[i])
		end
		c = extents[i + 1].sub(extents[i + 1], #extents[i + 1], #extents[i + 1])
		if c == ')' then
			extent = extents[i + 1].sub(extents[i + 1], 1, #extents[i + 1] - 1)
			value2 = 1 - var2:getMembershipDegree(extent)
		else
			value2 = var2:getMembershipDegree(extents[i + 1])
		end
		if relation[i] == "or" then
			if result == nil then result = math.max(value1, value2)
			else result = math.max(result, value2) end
		elseif relation[i] == "and" then
			if result == nil then result = math.min(value1, value2)
			else result = math.min(result, value2) end
		end
	end
	return result
end

function FuzzySet:addRule(state, rule)
	if self.membershipDegree == nil then self.membershipDegree = {} end
	self.membershipDegree[state] = self:ruleDeal(rule)
end

function FuzzySet:printResult()
	for k, v in pairs(self.membershipDegree) do
		print(k, v)
	end
end

function FuzzySet:defuzzy(deal, args)
	local res = 0
	local sum = 0
	if deal == "Max" then
		for k, v in pairs(self.membershipDegree) do
			if v > res then res = v end
		end
		return res
	elseif deal == "WeightSum" then
		for k, v in pairs(args) do
			for s, t in pairs(self.membershipDegree) do
				if s == k then 
					res = res + v * t
					sum = sum + t
					break
				end
			end
		end
		return res / sum
	end
end
