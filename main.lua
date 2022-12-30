-- lsystems

require "lsys"

local Lstest = {}

-- love wrapper

function love.load(arg)
	Lstest = Lsys:new()
	Lstest.rules = {["A"] = "AB", ["B"] = "A"}
	Lstest.words = {"A"}
	Lstest:pregen_order(10)
end

function love.draw()
	love.graphics.print("hello world", 400, 300)
	for i=1,10 do
		love.graphics.print(Lstest.words[i], 20, i*50 + 50)
	end
end

function love.update(dt)

end

