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
	
	textures = {
		['background'] = love.graphics.newImage('graphics/background.png'),
		['main'] = love.graphics.newImage('graphics/main.png'),
		['bricks'] = love.graphics.newImage('graphics/bricks.png'),
		['hearts'] = love.graphics.newImage('graphics/hearts.png')
	}
	
	quads = {
		['bricks'] = GenerateQuads(textures['bricks'], 32, 16)
	}	
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
	
	sounds = {}
	
	stateMachine = StateMachine {
		['start-menu'] = function() return StartMenuState() end
	}
	
	stateMachine:change('start-menu')
	
	love.keyboard.keysPressed = {}
end

function love.update()
	stateMachine:update(dt)
	
	love.keyboard.keysPressed = {}
end

function love.draw()
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
	
	love.graphics.draw(textures['background'], 0, 0, 0, VIRTUAL_WIDTH / backgroundWidth, VIRTUAL_HEIGHT / backgroundHeight)
	
	stateMachine:render()
	
	push:finish()
end