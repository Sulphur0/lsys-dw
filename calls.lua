function lsys_forward_draw(arg)
	love.graphics.setColor(arg.color)
	love.graphics.setLineWidth(arg.size)
	love.graphics.line(0,0,arg.length,0)
	love.graphics.translate(arg.length,0)
end

function lsys_forward(arg)
	love.graphics.translate(arg.length,0)
end

function lsys_push()
	love.graphics.push()
end

function lsys_pop()
	love.graphics.pop()
end

function lsys_rotate(arg)
	love.graphics.rotate(arg.theta)
end

