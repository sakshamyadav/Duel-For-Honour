local betatest = {}
local betaBanner; 
local selection; 
local pointer; 

local function menu() 
	mode = require 'menu'
	mode.load() 
end 

local options = { 
	{['text'] = 'Return to Menu', ['action'] = menu},
	{['text'] = 'Exit Game', ['action'] = love.event.quit}
}

function betatest.load() 
	background = love.graphics.newImage(MAINBG)
	betaBanner = love.graphics.newImage(BETATEST)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = betatest
end

function betatest.update() 
return mode 
end 

function betatest.draw() 
	love.graphics.draw(background)
	love.graphics.draw(betaBanner, 400,10)
	for i=1,#options do 
	if i == selection then 
		love.graphics.draw(pointer, 500, 470 + i * 30)
	end
		love.graphics.printf(options[i].text,0,470 + i * 30, love.graphics.getWidth(), 'center') 
		love.graphics.printf("Zac Giarratano \n \n Kinari Furusawa \n \n Markus Rangan \n \n Timothy Nario", 0, 200, love.graphics.getWidth(), 'center')
	end
end

function betatest.keypressed(key) 
	if key == 'up' then 
		selection = (selection - 2) % (#options) + 1 
	elseif key == 'down' then 
		selection = (selection) % (#options) + 1 
	elseif key == 'return' then 
		options[selection].action() 
	end
end

return betatest

