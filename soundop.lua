local soundop = {}
local selection; 
local pointer; 
local soundbanner; 
local sfx = true
local music = true
local fieldSound = true

local function menu() 
	mode = require 'menu'
	mode.load() 
end

local function muteMusic()
	if music then
		toggleoff:stop()
		toggleoff:play()
		bgMusic:setVolume(0)
		gameMusic:setVolume(0)
		music = false 
	else 
		music = true
		toggleon:stop()
		toggleon:play()
		bgMusic:setVolume(1)
		gameMusic:setVolume(0.8)
	end
end

local function muteSFX()
	if sfx then
		toggleoff:stop()
		toggleoff:play()
		gotshock:setVolume(0)
		p1bul:setVolume(0)
		bulletCol:setVolume(0)
		shieldgone:setVolume(0)
		shieldhit:setVolume(0)
		gotshot:setVolume(0)
		p2bul:setVolume(0)
		sfx = false
	else
		sfx = true
		toggleon:stop()
		toggleon:play()
		gotshock:setVolume(1)
		bulletCol:setVolume(1)
		shieldhit:setVolume(1)
		shieldgone:setVolume(1)
		p1bul:setVolume(0.4)
		gotshot:setVolume(1)
		p2bul:setVolume(0.4)
	end
end

local function muteField()
	if fieldSound then 
		toggleoff:stop()
		toggleon:play()
		electric:setVolume(0)
		fieldSound = false
	else 
		fieldSound = true 
		toggleon:stop()
		toggleon:play()
		electric:setVolume(0.8)
	end
end



local options = { 
	{['text'] = 'Mute Music', ['action'] = muteMusic},
	{['text'] = 'Mute Electric Force Field', ['action'] = muteField},
	{['text'] = 'Mute Sound Effects', ['action'] = muteSFX},
	{['text'] = 'Return to Menu', ['action'] = menu}

}

function soundop.load() 
	background = love.graphics.newImage(MAINBG)
	soundbanner = love.graphics.newImage(SOUNDBANNER)
	volume = love.graphics.newImage(VOL)
	novol = love.graphics.newImage(VOLMUTE)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = soundop
end

function soundop.update()
	return mode 
end

function soundop.draw()
	love.graphics.draw(background)
	love.graphics.draw(soundbanner, 400,10)
	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 480, 470 + i * 30)
		end 
		love.graphics.printf(options[i].text,0,470 + i * 30, love.graphics.getWidth(), 'center')
	end
	if music then
		love.graphics.printf("MUSIC: ON", 0, 200, love.graphics.getWidth(), 'center')
		love.graphics.draw(volume, 580, 230)
	else 
		love.graphics.printf("MUSIC: OFF", 0, 200, love.graphics.getWidth(), 'center')
		love.graphics.draw(novol, 580, 230)
	end

	if fieldSound then
		love.graphics.printf("FORCEFIELD SOUND: ON", 0, 300, love.graphics.getWidth(), 'center' )
		love.graphics.draw(volume, 580, 330)
		else
		love.graphics.printf("FORCEFIELD SOUND: OFF", 0, 300, love.graphics.getWidth(), 'center')
		love.graphics.draw(novol, 580, 330)
	end

	if sfx then
		love.graphics.printf("SOUND EFFECTS: ON", 0, 400, love.graphics.getWidth(), 'center')
		love.graphics.draw(volume, 580, 430)
	else
		love.graphics.printf("SOUND EFFECTS: OFF", 0, 400, love.graphics.getWidth(), 'center')
		love.graphics.draw(novol, 580, 430)
	end
end

function soundop.keypressed(key)
	if key == 'up' then 
		selection = (selection - 2) % (#options) + 1 
	elseif key == 'down' then 
		selection = (selection) % (#options) + 1 
	elseif key == 'return' then 
		options[selection].action() 
	end
end

return soundop 
