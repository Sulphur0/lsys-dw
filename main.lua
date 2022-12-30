-- lsystems

require "lsys"
require "calls"

local Lstest = {}

-- love wrapper

function love.load(arg)
	Lstest = Lsys:new()
	Lstest.rules = {["A"] = "ABA", ["B"] = "BBB"}
	Lstest.words = {"A"}
	Lstest.calls = {["A"] = {lsys_forward_draw,{length=5,size=2,color={255,255,255}}}, ["B"] = {lsys_forward,{length=5}}}
	Lstest:pregen_order(5)
	love.graphics.setDefaultFilter("nearest","nearest",0)
	love.graphics.setLineStyle("rough")
end

function love.draw()
	--love.graphics.print("hello world", 400, 300)
	for i=1,5 do
		drawmedium = love.graphics.newCanvas(800,600)
		love.graphics.setCanvas(drawmedium)
		--love.graphics.print(Lstest.words[i], 20, i*50 + 50)
		Lstest:draw(i,0,0)
		love.graphics.setCanvas()
		love.graphics.push()
		love.graphics.translate(50,50+20*i)
		love.graphics.scale(3^(5-i),1)
		love.graphics.draw(drawmedium,0,0)
		love.graphics.pop()
	end
end

function love.update(dt)

end

