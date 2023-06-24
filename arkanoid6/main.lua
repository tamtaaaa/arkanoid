require 'src/Dependencies'

function love.load()
	io.stdout:setvbuf("no")
	
	love.graphics.setDefaultFilter('nearest', 'nearest')
	
	love.window.setTitle('arkanoid')
	
	math.randomseed(os.time())
	
	fonts = {
		['large'] = love.graphics.newFont('fonts/font.ttf', 32),
		['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
		['small'] = love.graphics.newFont('fonts/font.ttf', 8)
	}
	
	sounds = {
		['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
		['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
		['select'] = love.audio.newSource('sounds/select.wav', 'static'),
		
		--https://freesound.org/people/Duisterwho/sounds/643569/
		['music'] = love.audio.newSource('sounds/arkanoid_music.mp3', 'static')
	}
	
	sounds['music']:setLooping(true)
	sounds['music']:play()
	
	textures = {
		['background'] = love.graphics.newImage('graphics/background.png'),
		['main'] = love.graphics.newImage('graphics/main.png'),
		['bricks'] = love.graphics.newImage('graphics/bricks.png'),
		['hearts'] = love.graphics.newImage('graphics/hearts.png')
	}
	
	quads = {
		['bricks'] = GenerateQuads(textures['bricks'], 32, 16),
		['paddles'] = table.slice(GenerateQuads(textures['main'], 32, 9), 1, 3),
		['balls'] = table.slice(GenerateQuads(textures['main'], 7, 7), 19, 25, 19),
		['hearts'] = GenerateQuads(textures['hearts'], 16, 16)
	}	
	
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
	
	
	stateMachine = StateMachine {
		['start-menu'] = function() return StartMenuState() end,
		['serve'] = function() return ServeState() end,
		['play'] = function() return PlayState() end,
		['game-over'] = function() return GameOverState() end,
		['highscore'] = function() return HighscoreState() end,
		['enter-highscore'] = function() return EnterHighscoreState() end
	}
	
	stateMachine:change('start-menu', {
		highscores = loadHighscores()
	})
	
	love.keyboard.keysPressed = {}
	
end

function love.update(dt)
	stateMachine:update(dt)
	
	love.keyboard.keysPressed = {}
end

function love.resize(width, height)
	push:resize(width, height)
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
	push:start()
	
	local backgroundWidth = textures['background']:getWidth()
	local backgroundHeight = textures['background']:getHeight()
	
	love.graphics.draw(textures['background'], 0, 0, 0, VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))
	
	stateMachine:render()
	
	push:finish()
end

function renderHealth(health)
	local healthX = 20
	
	for i = 1, health do
		love.graphics.draw(textures['hearts'], quads['hearts'][8], healthX, 5)
		healthX = healthX + 12
	end
	
	for i = 1, 3 - health do
		love.graphics.draw(textures['hearts'], quads['hearts'][1], healthX, 5)
		healthX = healthX + 12
	end
end

function renderScore(score)
	love.graphics.setFont(fonts['small'])
	love.graphics.print('Score: ', VIRTUAL_WIDTH - 100, 5)
	love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end

function loadHighscores()
	love.filesystem.setIdentity('arkanoid')
	
	if not love.filesystem.getInfo('arkanoid.lst') then
		local scores = ''
		for index = 10, 1, -1 do
			scores = scores .. 'NAM\n'
			scores = scores .. 0 .. '\n'
		end
		
		love.filesystem.write('arkanoid.lst', scores)
	end
	
	local name = true
	local currentName = nil
	local counter = 1
	
	local scores = {}
	
	for index = 1, 10 do
		scores[index] = {
			name = nil,
			score = nil
		}
	end
	
	for line in love.filesystem.lines('arkanoid.lst') do
		if name then
			scores[counter].name = string.sub(line, 1, 3)
		else
			scores[counter].score = tonumber(line)
			counter = counter + 1
		end
		
		name = not name
	end
	
	return scores
end
