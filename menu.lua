local menu = {}
local selection; 
local bannerMenu; 
local pointer; 
operSys = love.system.getOS() 

local function play() 
	mode = require 'game'
	mode.load() 
end 

local function instructions() 
	mode = require 'instructions'
	mode.load() 
end 

local function betatest() 
	mode = require 'betatest'
	mode.load() 
end 

local function changelog() 
	mode = require 'changelog'
	mode.load() 
end 

local function soundop() 
	mode = require 'soundop'
	mode.load() 
end 

local options = { 
{['text'] = 'Play', ['action'] = play},
{['text'] = 'Controls/Instructions', ['action'] = instructions},
{['text'] = 'Beta Testers', ['action'] = betatest},
{['text'] = 'Changelog', ['action'] = changelog},
{['text'] = 'Sound Options', ['action'] = soundop},
{['text'] = 'Exit Game', ['action'] = love.event.quit}
}

function menu.load() 
	background = love.graphics.newImage(MAINBG)
	bannerMenu = love.graphics.newImage(MENUBANNER)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = menu 
	mac = love.graphics.newImage(MAC)
	windows = love.graphics.newImage(WINDOWS)
	linux = love.graphics.newImage(LINUX)
end

function menu.update() 
	return mode
end 

function menu.draw() 
	love.graphics.draw(background)
	love.graphics.draw(bannerMenu, 400,10)
	love.graphics.printf("This version is developed for "..tostring(love.system.getOS()),0,570,love.graphics.getWidth(), 'center') 
	love.graphics.printf("----- Created by Saksham Yadav -----",0 , 680, love.graphics.getWidth(), 'center')
	love.graphics.printf("VERSION (BETA)", 598,620, love.graphics.getWidth())
	if operSys == "OS X" then 
		love.graphics.draw(mac, 520,590)
	end
	if operSys == "Windows" then 
		love.graphics.draw(windows,520,590) 
	end
	if operSys == "Linux" then 
		love.graphics.draw(linux, 520,590)
	end

	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 450, 160 + i * 50)
		end 
		love.graphics.printf(options[i].text,-10,160 + i * 50, love.graphics.getWidth(), 'center')
	end 
end 

function menu.keypressed(key)
	if key == "up" then 
			selection = (selection - 2) % (#options) + 1 
	elseif key == "down" then 
			selection = (selection) % (#options) + 1 
	elseif key == "return" then 
			options[selection].action() 
	end 
 	if key == "escape" then 
 		love.event.quit() 
 	end 
end 

return menu 