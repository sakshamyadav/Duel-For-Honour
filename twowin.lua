local twowin = {}
local selection; 
local pointer; 
local p2winbanner; 

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

function twowin.load() 
	background = love.graphics.newImage(MAINBG)
	p2winbanner = love.graphics.newImage(P2WIN)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = twowin
end

function twowin.update()
	return mode 
end

function twowin.draw()
	love.graphics.draw(background)
	love.graphics.draw(p2winbanner, 400,10)
		for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 500, 350 + i * 30)
		end 
		love.graphics.printf(options[i].text,0,350 + i * 30, love.graphics.getWidth(), 'center') 
	end 
end 

function twowin.keypressed(key)
		if key == "up" then 
			selection = (selection - 2) % (#options) + 1 
	elseif key == "down" then 
			selection = (selection) % (#options) + 1 
	elseif key == "return" then 
			options[selection].action() 
	end 
end

return twowin
