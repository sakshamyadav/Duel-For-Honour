require ("AnAL")
local instructions = {}
local instructionbanner; 
local selection;
local pointer;

local function menu()
	mode = require 'menu'
	mode.load() 
end 

local function play() 
	mode = require 'game'
	mode.load() 
end 

local options = {
	{['text'] = 'Play', ['action'] = play},
	{['text'] = 'Return to Menu', ['action'] = menu},
	{['text'] = 'Exit Game', ['action'] = love.event.quit}
}

function instructions.load() 
	background = love.graphics.newImage(MAINBG)
	p1controls = love.graphics.newImage(P1CONTROLS)
	p2controls = love.graphics.newImage(P2CONTROLS)
	instructionbanner = love.graphics.newImage(INSTRUCTIONS)
	selection = 1 
	lightning = love.graphics.newImage(LIGHTNING)
	pointer = love.graphics.newImage(POINTER)
	anim = newAnimation(lightning, 20, 300, -3000, 0)
	anim:setMode("bounce")
	mode = instructions 
end 

function instructions.update(dt)
	anim:update(dt)
	return mode 
end 

function instructions.draw() 
	love.graphics.draw(background)
	love.graphics.draw(p1controls, 800,70)
	anim:draw(430,200)
	anim:draw(780,200)
	love.graphics.draw(p2controls, 100, 70)
	love.graphics.draw(instructionbanner,400,10)
	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 500, 530 + i * 30)
		end 
		love.graphics.printf(options[i].text,0,530 + i * 30, love.graphics.getWidth(), 'center')
	end
	love.graphics.printf("-->BEWARE OF THE ELECTRIC FIELD \n \n \n  -->ONLY BULLETS CAN PASS THROUGH THE FIELD \n \n \n -->EACH PLAYER RECEIVES 3 LIVES \n \n \n --> YOU MUST DESTROY YOUR OPPONENT'S SHIELD \n \n BEFORE THEY CAN SUFFER DAMAGE \n \n \n  -->YOUR AIM IS TO ELIMINATE THE OTHER PLAYER \n \n BEFORE THEY ELIMINATE YOU \n \n \n -->PRESS 'P' TO PAUSE ANYTIME DURING THE GAME" , 10, 200, love.graphics.getWidth(), 'center')
end

function instructions.keypressed(key)
	if key == 'up' then 
		selection = (selection - 2) % (#options) + 1 
	elseif key == 'down' then 
		selection = (selection) % (#options) + 1 
	elseif key == 'return' then 
		options[selection].action() 
	end
end

return instructions