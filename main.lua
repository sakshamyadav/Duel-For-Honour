--config file 
require 'conf'

--load all images
WINDOWS = 'Images/windows.png'
LINUX = 'Images/linux.png'
MAC = 'Images/mac.png'
POINTER = 'Images/pointer.png'
MENUBANNER = 'Images/menu.png'
MAINBG = 'Images/background.png'
PLAYER1 = 'Images/player1.png'
PLAYER2 = 'Images/player2.png'
BETATEST = 'Images/betatest.png'
P1BULLET = 'Images/p1bullet.png'
P2BULLET = 'Images/p2bullet.png'
CHANGELOG = 'Images/changelog.png'
INSTRUCTIONS = 'Images/instructions.png'
SOUNDBANNER = 'Images/soundops.png'
P1WIN = 'Images/player1win.png'
P2WIN = 'Images/player2win.png'
P1HEALTH = 'Images/p1health.png'
P2HEALTH = 'Images/p2health.png'
GAMEBG1 = 'Images/gamebg.jpeg'
GAMEBG2 = 'Images/gamebg2.jpeg'
LIGHTNING = 'Images/lightning.png'
P1CONTROLS = 'Images/p1controls.png'
P2CONTROLS = 'Images/p2controls.png'
P1HTEXT = 'Images/p1healthtxt.png'
P2HTEXT = 'Images/p2healthtxt.png'
PAUSED = 'Images/paused.png'
VOL = 'Images/vol.png'
VOLMUTE = 'Images/volmute.png'
P1SHIELD = 'Images/p1shield.png'
P2SHIELD = 'Images/p2shield.png'
EXPLOSION = 'Images/explosion.png'
CAUTION = 'Images/elec.png'
P1SHIELD80 = 'Images/p1shield80.png'
P1SHIELD50 = 'Images/p1shield50.png'
P1SHIELD20 = 'Images/p1shield20.png'
P1SHIELD10 = 'Images/p1shield10.png'
P2SHIELD80 = 'Images/p2shield80.png'
P2SHIELD50 = 'Images/p2shield50.png'
P2SHIELD20 = 'Images/p2shield20.png'
P2SHIELD10 = 'Images/p2shield10.png'
P1LIGHTNING = 'Images/p1lightning.png'
P2LIGHTNING = 'Images/p2lightning.png'



--load all sound 
bgMusic = love.audio.newSource("Sound/mainmusic.mp3")
gameMusic = love.audio.newSource("Sound/gamemusic.mp3")
p1bul = love.audio.newSource("Sound/p1shot.mp3")
p2bul = love.audio.newSource("Sound/p2shot.mp3")
gotshot = love.audio.newSource("Sound/gotshot.mp3")
electric = love.audio.newSource("Sound/forcefield.mp3")
gotshock = love.audio.newSource("Sound/gotshock.mp3")
toggleon = love.audio.newSource("Sound/toggleon.mp3")
toggleoff = love.audio.newSource("Sound/toggleoff.mp3")
shieldhit = love.audio.newSource("Sound/shieldhit.mp3")
shieldgone = love.audio.newSource("Sound/shieldgone.mp3")
bulletCol = love.audio.newSource("Sound/bulcol.mp3")

--set looping for background music
bgMusic:play()
bgMusic:setLooping(true)
-- set volumes 
bgMusic:setVolume(1)
bulletCol:setVolume(1)
shieldhit:setVolume(1)
gotshock:setVolume(1)
electric:setVolume(0.8)
p1bul:setVolume(0.4)
gotshot:setVolume(1)
shieldgone:setVolume(1)
p2bul:setVolume(0.4)
gameMusic:setVolume(0.6)

-- main functions 
function love.load() 
	mode = require "menu"
	mode.load() 
end 

function love.draw() 
	mode.draw() 
end 

function love.keypressed(key, isrepeat)
	mode.keypressed(key)
end 

function love.update(dt)
	mode.update(dt) 
end 

