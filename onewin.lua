local onewin = {}
local selection; 
local pointer; 
local p1winbanner;

local function play()
	mode = require 'game'
	mode.load()
end

local function menu() 
	mode = require 'menu'
	mode.load()
end

local options = {
	{['text'] = 'Play Again', ['action'] = play},
	{['text'] = 'Return to Menu', ['action'] = menu},
	{['text'] = 'Exit Game', ['action'] = love.event.quit}
}

function onewin.load()
	background = love.graphics.newImage(MAINBG)
	p1winbanner = love.graphics.newImage(P1WIN)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = onewin 
end

function onewin.update()
	return mode
end

function onewin.draw()
	love.graphics.draw(background)
	love.graphics.draw(p1winbanner, 400,10)
	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 500, 350 + i * 30)
		end 
		love.graphics.printf(options[i].text,0,350 + i * 30, love.graphics.getWidth(), 'center') 
	end 
end 

function onewin.keypressed(key)
		if key == "up" then 
			selection = (selection - 2) % (#options) + 1 
	elseif key == "down" then 
			selection = (selection) % (#options) + 1 
	elseif key == "return" then 
			options[selection].action() 
	end 
end

return onewin
