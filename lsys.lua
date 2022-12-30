-- randomness
math.randomseed(os.time())
-- rules are 'key' 'value' pairs, where 'key' is the pattern and 'values' are the possible morphisms along their probability of occurence

Lsys = {rules = {}, words = {}, calls = {}, angle = 0}

function Lsys:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Lsys:pregen_order(n)
	-- sort the keys by descending length
	local tkeys = {}
	for k in pairs(self.rules) do table.insert(tkeys, k) end
	table.sort(tkeys, function (a,b) return string.len(a) < string.len(b) end)
	-- tkeys holds sorted key values
	-- we can now gsub keys for values
	local current_word = self.words[1]
	for i = 1 , n do
	local ww_len = string.len(current_word)
	local next_word = ""
	for j = 1, ww_len do
	local replace_string = current_word:sub(j,j)
	for _,k in ipairs(tkeys) do
		if current_word:sub(j,j+string.len(k)-1):find(k) then
			-- we found the key that matches and can now replace
			replace_string = self.rules[k]
			if type(replace_string) == "table" then
				-- multiple replacements, use probability
				local rnd, rp = math.random(), 0
				for _,v in ipairs(replace_string) do
					rp = rp + v[2]
					if rnd <= rp then replace_string = v[1] break end
				end
			end
			j = j + string.len(k) - 1
			break
		end
	end
	next_word = next_word..replace_string
	end
	table.insert(self.words,next_word)
	current_word = next_word
	end
end

function Lsys:draw(order, x, y)
	-- assert that the order is cached
	if self.words[order] then
	-- rotate the space by the initial angle of the lsystem
	love.graphics.push()
	love.graphics.translate(x,y)
	love.graphics.rotate(self.angle)
	-- sort the keys by descending length
	local tkeys = {}
	for k in pairs(self.calls) do table.insert(tkeys, k) end
	table.sort(tkeys, function (a,b) return string.len(a) < string.len(b) end)
	-- tkeys holds sorted calls
	-- call function associated 
	for j = 1, string.len(self.words[order]) do
	for _,k in ipairs(tkeys) do
		if self.words[order]:sub(j,j+string.len(k)-1):find(k) then
			-- call the associated function
			if not (self.calls[k] == nil) then self.calls[k][1](self.calls[k][2]) end
			j = j + string.len(k) - 1
			break
		end
	end
	end
	love.graphics.pop()
	end
end

