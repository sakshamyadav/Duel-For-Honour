local changelog = {}
local changebanner; 
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

function changelog.load()
	background = love.graphics.newImage(MAINBG)
	changebanner = love.graphics.newImage(CHANGELOG)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = changelog
end

function changelog.draw() 
	love.graphics.draw(background)
	love.graphics.draw(changebanner, 400,10)
	for i=1,#options do 
	if i == selection then 
		love.graphics.draw(pointer, 500, 470 + i * 30)
	end
		love.graphics.printf(options[i].text,0,470 + i * 30, love.graphics.getWidth(), 'center') 
	end
end

function changelog.update() 
	return mode 
end 

function changelog.keypressed(key) 
	if key == 'up' then 
		selection = (selection - 2) % (#options) + 1 
	elseif key == 'down' then 
		selection = (selection) % (#options) + 1 
	elseif key == 'return' then 
		options[selection].action() 
	end
end

return changelog
