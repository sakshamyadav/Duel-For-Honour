require("AnAL")
local game = {}
local player1 = {}
local player2 = {}
local player1Buls = {}
local player2Buls = {}
local player1Health = 3
local player2Health = 3
local p1Healthimage;
local p2Healthimage;
local pause = false 
local bg1 = {}
local bg2 = {}

-- IF PLAYER ONE WINS
local function onewins() 
	gameMusic:stop()
	electric:stop()
	bgMusic:play()
	bgMusic:setLooping(true)
	mode = require 'onewin'
	mode.load() 
end

--IF PLAYER TWO WINS
local function twowins() 
	gameMusic:stop()
	bgMusic:play()
	bgMusic:setLooping(true)
	electric:stop()
	mode = require 'twowin'
	mode.load()
end

--PLAYER ONE BULLETS
local function player1Shoots() 
	if not pause then
		local bullet = {}
		bullet.x = player1.x
		bullet.y = player1.y + 26
		table.insert(player1Buls, bullet)
		love.audio.stop(p1bul)
		love.audio.play(p1bul)
	end
end

--CLEAR ALL TABLES
local function cleartables(t)
	for i = #t,1,-1 do 
		table.remove(t, i)
	end
end

-- INITIALISATION - START OF EACH GAME
local function initialise()
	shieldhitCounter1 = 0 
	shieldhitCounter2 = 0 
	counter1 = 0 
	counter2 = 0 
	counterelec1 = 0 
	counterelec2 = 0 
	p1elecAnim = false
	p2elecAnim = false 
	p1shield = true
	p2shield = true
	p1hitAnim = false
	p2hitAnim = false 
	cleartables(player1Buls)
	cleartables(player2Buls)
	bgMusic:stop()
	gameMusic:play()
	gameMusic:setLooping(true)
	electric:play()
	electric:setLooping(true)
end

-- PLAYER TWO BULLETS
local function player2Shoots() 
	if not pause then
		local bullet2 = {}
		bullet2.x = player2.x 
		bullet2.y = player2.y + 26
		table.insert(player2Buls, bullet2)
		love.audio.stop(p2bul)
		love.audio.play(p2bul)
	end
end

--PLAYER TWO SHIELD HIT COUNTER
local function p2shieldcounter()
	shieldhitCounter2 = shieldhitCounter2 + 1 
	if shieldhitCounter2 == 20 then
		p2shield = not p2shield
		love.audio.play(shieldgone)
	end
end

-- PLAYER 2 HEALTH COUNTER 
local function player2getsShot()
	player2Health = player2Health - 1
	if player2Health == 0 then
		onewins()
	end
end

-- PLAYER ONE SHIELD HIT COUNTER
local function p1shieldcounter()
	shieldhitCounter1 = shieldhitCounter1 + 1 
	if shieldhitCounter1 == 20 then
		p1shield = not p1shield
		love.audio.play(shieldgone)
	end
end

-- PLAYER ONE HEALTH COUNTER
local function player1getsShot()
	player1Health = player1Health - 1 
	if player1Health == 0 then
		twowins()
	end
end

local function bulletsCollide()
	for i = #player1Buls, 1, -1 do 
		for j = #player2Buls, 1, -1 do 
			if next(player1Buls) ~= nil and player1Buls[i] ~= nil and 
				next(player2Buls) ~= nil and player2Buls[i] ~= nil and
				player1Buls[i].x <= player2Buls[j].x and player1Buls[i].x + 30 >= player2Buls[j].x and
				player1Buls[i].y <= player2Buls[j].y + 2 and player1Buls[i].y + 2 >= player2Buls[j].y then 
				table.remove(player1Buls, i)
				table.remove(player2Buls, j)
				love.audio.stop(bulletCol)
				love.audio.play(bulletCol)
			end
		end
	end
end


-- PLAYER ONE SHOOTING AT PLAYER TWO 
local function player1Shots(dt) 
	if not pause then
		if next(player1Buls) ~= nil then
			for i = #player1Buls, 1, -1 do 
				player1Buls[i].x = player1Buls[i].x - dt * player1.bulletSpeed
		if player1Buls[i].x < 0 then
			table.remove(player1Buls, i)
		end

		if not p2shield then 
			if next(player1Buls) ~= nil and player1Buls[i] ~= nil and
			player2.x <= player1Buls[i].x and player2.x + 30 >= player1Buls[i].x
			and player2.y <= player1Buls[i].y + 20 and player2.y + 65 >= player1Buls[i].y then
				table.remove(player1Buls, i)
				player2getsShot()
				p2hitAnim = true 
				love.audio.stop(gotshot)
				love.audio.play(gotshot)
			end
		end
		if p2shield then 
			if next(player1Buls) ~= nil and player1Buls[i] ~= nil and
			player2.x <= player1Buls[i].x+ 40  and player2.x + 70 >= player1Buls[i].x
			and player2.y <= player1Buls[i].y + 40 and player2.y + 105 >= player1Buls[i].y then
				table.remove(player1Buls, i)
				p2shieldcounter()
				love.audio.stop(shieldhit)
				love.audio.play(shieldhit)
			end
		end
			end
		end
	end
end

-- PLAYER TWO SHOOTING AT PLAYER ONE 
local function player2Shots(dt)
	if not pause then
		if next(player2Buls) ~= nil then
			for i = #player2Buls, 1, -1 do 
				player2Buls[i].x = player2Buls[i].x + dt * player2.bulletSpeed
		if player2Buls[i].x > 1200 then 
			table.remove(player2Buls, i)
		end

		if not p1shield then
			if next(player2Buls) ~= nil and player2Buls[i] ~= nil and
			player1.x <= player2Buls[i].x and player1.x + 30 >= player2Buls[i].x
			and player1.y <= player2Buls[i].y + 20 and player1.y + 65 >= player2Buls[i].y then
				table.remove(player2Buls, i)
				player1getsShot()
				p1hitAnim = true 
				love.audio.stop(gotshot)
				love.audio.play(gotshot)
			end 
		end
		if p1shield then  
			if next(player2Buls) ~= nil and player2Buls[i] ~= nil and
			player1.x <= player2Buls[i].x + 50 and player1.x + 109 >= player2Buls[i].x
			and player1.y <= player2Buls[i].y + 40 and player1.y + 105 >= player2Buls[i].y then
				table.remove(player2Buls, i)
				p1shieldcounter()
				love.audio.stop(shieldhit)
				love.audio.play(shieldhit)
			end
		end
			end
		end
	end
end



-- LOADING ALL GAME ASSETS 
function game.load() 
	player1Health = 3 
	player2Health = 3 
	player1.speed = 600
	player2.speed = 600 
	player1.width = 80
	player1.height = 69 
	player2.width = 80
	player2.height = 69
	player1.bulletSpeed = 1000 
	player2.bulletSpeed = 1000 
	player1.image = love.graphics.newImage(PLAYER1)
	caution = love.graphics.newImage(CAUTION)
	player2.image = love.graphics.newImage(PLAYER2)
	p1healthtxt = love.graphics.newImage(P1HTEXT)
	p2healthtxt = love.graphics.newImage(P2HTEXT)
	paused = love.graphics.newImage(PAUSED)
	player1Buls.image = love.graphics.newImage(P1BULLET)
	player2Buls.image = love.graphics.newImage(P2BULLET)
	player1.x = 1100
	player1.y = 315
	player2.x = 30
	player2.y = 315
	p1Healthimage = love.graphics.newImage(P1HEALTH)
	p2Healthimage = love.graphics.newImage(P2HEALTH)
	bg1.img = love.graphics.newImage(GAMEBG1)
	bg1.x = 1200 
	bg2.img = love.graphics.newImage(GAMEBG2)
	bg2.x = 0 
	scrollSpeed = 300
	lightning= love.graphics.newImage(LIGHTNING)
	explosion = love.graphics.newImage(EXPLOSION)
	p1shock = love.graphics.newImage(P1LIGHTNING)
	p2shock = love.graphics.newImage(P2LIGHTNING)
	exploanim = newAnimation(explosion, 64,64,0.1,0)
	anim = newAnimation(lightning, 20,700, -3000,0)
	p2lightning = newAnimation(p2shock, 80,69,-3000,0)
	p2lightning:setMode("bounce")
	p1lightning = newAnimation(p1shock, 80,69, -3000,0)
	p1lightning:setMode("bounce")
	anim:setMode("bounce")
	initialise() 
end

-- DRAWING ALL GAME ASSETS
function game.draw() 
	love.graphics.draw(bg1.img, bg1.x, 0)
	love.graphics.draw(bg2.img, bg2.x, 0)
	if p1shield then
		love.graphics.draw(shield1, player1.x-30, player1.y -35)
	end

	if p2shield then
		love.graphics.draw(shield2, player2.x- 37, player2.y-33)
	end

	if next(player1Buls) ~= nil then 
		for i = 1, #player1Buls do 
			love.graphics.draw(player1Buls.image, player1Buls[i].x, player1Buls[i].y)
		end
	end

	if next(player2Buls) ~= nil then
		for i = 1, #player2Buls do 
			love.graphics.draw(player2Buls.image, player2Buls[i].x, player2Buls[i].y)
		end
	end

	love.graphics.draw(player1.image, player1.x, player1.y)
	love.graphics.draw(player2.image, player2.x, player2.y)
	if p1elecAnim == true then 
		p1lightning:draw(player1.x, player1.y)
	end
	if p2elecAnim == true then 
		p2lightning:draw(player2.x, player2.y)
	end
	if p1hitAnim == true then
		exploanim:draw(player1.x, player1.y)
	end
	if p2hitAnim == true then
		exploanim:draw(player2.x, player2.y)
	end
	anim:draw(585,50)
	
	if pause then
		love.graphics.draw(paused, 200, 10)
	end
--IF NOT PAUSE THEN
	if not pause then
		love.graphics.draw(caution, 570, 15)
	

	for i = 1, player1Health do 
		love.graphics.draw(p1Healthimage, 1000 + i *40, 15)
	end

	for i = 1, player2Health do 
		love.graphics.draw(p2Healthimage, 300 + i * 40, 15)
	end

	love.graphics.draw(p1healthtxt, 700, 10)
	love.graphics.draw(p2healthtxt,5, 10 )

	if shieldhitCounter1 ~= 20 then 
		if shieldhitCounter1 == 0 then 
			love.graphics.print("SHIELD: 100%", 630,25)
		else 
			love.graphics.print("SHIELD: "..(100-((shieldhitCounter1/20)*100)).."%", 630,25)
		end
	end

	if shieldhitCounter2 ~= 20 then
		if shieldhitCounter2 == 0 then
			love.graphics.print("SHIELD: 100%", 470,25)
		else 
			love.graphics.print("SHIELD: "..(100-((shieldhitCounter2/20)*100)).."%", 470,25)
		end

	end
	end 
end 

-- UPDATING: ANIMATIONS, MOVEMENT, PLAYER CONTROLS, BOUNDARIES
function game.update(dt)
	if not pause then 
		--bg1.x = 1200
		--bg2.x = 0 
		bg1.x = bg1.x - scrollSpeed * dt 
		bg2.x = bg2.x - scrollSpeed * dt 

		if bg2.x < -1200 then 
			bg2.x = 1200
		end
		if bg1.x < -1200 then 
			bg1.x = 1200
		end
		-- PLAYER 1 ANIMATION HIT STOP
		if p1hitAnim == true then 
			counter1 = counter1 + dt 
			if counter1 > 1 then 
				p1hitAnim = false 	
			end
		end 
	if p1hitAnim == false then 
		counter1 = 0
	end

	--PLAYER 2 ANIMATION HIT STOP 
	if p2hitAnim == true then 
		counter2 = counter2 + dt 
		if counter2 > 1 then 
			p2hitAnim = false 
		end
	end
	if p2hitAnim == false then 
		counter2 = 0 
	end

	--PLAYER 1 ELEC ANIMATION STOP
	if p1elecAnim == true then
		counterelec1 = counterelec1 + dt 
		if counterelec1 > 1 then 
			p1elecAnim = false 
		end
	end
	if p1elecAnim == false then 
		counterelec1 = 0 
	end

	--PLAYER 2 ELEC ANIMATION STOP 
	if p2elecAnim == true then 
		counterelec2 = counterelec2 + dt 
		if counterelec2 > 1 then 
			p2elecAnim = false 
		end
	end
	if p2elecAnim == false then 
		counterelec2 = 0 
	end

	--SHIELD 1 UPDATES
	if shieldhitCounter1 == 0 then
		shield1 = love.graphics.newImage(P1SHIELD)
	end
	if shieldhitCounter1 > 0 and shieldhitCounter1 < 2  then
		shield1 = love.graphics.newImage(P1SHIELD80)
	end
	if shieldhitCounter1 > 2 and shieldhitCounter1 < 4 then
		shield1 = love.graphics.newImage(P1SHIELD50)
	end
	if shieldhitCounter1 > 4 and shieldhitCounter1 < 10 then
		shield1 = love.graphics.newImage(P1SHIELD20)
	end
	if shieldhitCounter1 > 10 and shieldhitCounter1 < 16 then
		shield1 = love.graphics.newImage(P1SHIELD10)
	end
	--SHIELD 2 UPDATES
	if shieldhitCounter2 == 0 then
		shield2 = love.graphics.newImage(P2SHIELD)
	end
	if shieldhitCounter2 > 0 and shieldhitCounter2 < 2 then
		shield2 = love.graphics.newImage(P2SHIELD80)
	end
	if shieldhitCounter2 > 2 and shieldhitCounter2 < 4 then
		shield2 = love.graphics.newImage(P2SHIELD50)
	end
	if shieldhitCounter2 > 4 and shieldhitCounter2 < 10 then
		shield2 = love.graphics.newImage(P2SHIELD20)
	end
	if shieldhitCounter2 > 10 and shieldhitCounter2 < 16 then
		shield2 = love.graphics.newImage(P2SHIELD10)
	end
	bulletsCollide()
	--ANIMATIONS
		anim:update(dt)
		p1lightning:update(dt)
		p2lightning:update(dt)
		exploanim:update(dt)
--player 1 controls
	if love.keyboard.isDown("right") then 
		player1.x = player1.x + dt * player1.speed 
	end
	if love.keyboard.isDown("left") then 
		player1.x = player1.x - dt * player1.speed
	end
	if love.keyboard.isDown("up") then
		player1.y = player1.y - dt * player1.speed
	end
	if love.keyboard.isDown("down") then
		player1.y = player1.y + dt * player1.speed
	end
--player 2 controls
	if love.keyboard.isDown("d") then
		player2.x = player2.x + dt * player2.speed
	end
	if love.keyboard.isDown("a") then
		player2.x = player2.x - dt * player2.speed
	end
	if love.keyboard.isDown("w") then
		player2.y = player2.y - dt * player2.speed
	end
	if love.keyboard.isDown("s") then
		player2.y = player2.y + dt * player2.speed
	end
	player1Shots(dt)
	player2Shots(dt)
--player1 boundaries
	if player1.y < 66 then
		player1.y = 66
	end
	if player1.y > 630 then
		player1.y = 630
	end
	if player1.x > 1120 then
		player1.x = 1120
	end
	if player1.x < 600 then
		if not p1shield then
			player1.x = 1100
			player1.y = 315
			love.audio.stop(gotshock)
			love.audio.play(gotshock)
			player1getsShot()
			p1elecAnim = true 
		else 
			player1.x = 600
			p1shieldcounter()
			love.audio.stop(shieldhit)
			love.audio.play(shieldhit)
		end
	end
--player2 boundaries
	if player2.x < 0 then
		player2.x = 0
	end
	if player2.y > 630 then
		player2.y = 630
	end
	if player2.y < 66 then
		player2.y = 66
	end
	if player2.x > 515 then
		if not p2shield then
			player2.x = 30
			player2.y = 315
			love.audio.stop(gotshock)
			love.audio.play(gotshock)
			player2getsShot()
			p2elecAnim = true 
		else 
			player2.x = 515
		p2shieldcounter()
		love.audio.stop(shieldhit)
		love.audio.play(shieldhit)
		end
	end
	end
end

--KEYPRESS FUNCTION: PAUSE, SHOOTING
function game.keypressed(key)
	if key == "p" then
		pause = not pause
	end
	if key == " " then
		player1Shoots()
	end
	if key == "lshift" then
		player2Shoots()
	end
	if pause then 
		if key == "escape" then
			gameMusic:stop()
			bgMusic:play() 
			bgMusic:setLooping(true)
			electric:stop()
			mode = require 'menu'
			mode.load()
			pause = not pause 
		end
	end
end

return game 
