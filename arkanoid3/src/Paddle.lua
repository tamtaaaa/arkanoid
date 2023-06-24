Paddle = Class{}

function Paddle:init()
	self.width = 32
	self.height = 9
	
	self.x = VIRTUAL_WIDTH / 2 - self.width / 2
	self.y = VIRTUAL_HEIGHT - 32
	
	self.dx = 0
	
	
	self.skin = 1
end

function Paddle:update(dt)
	if love.keyboard.isDown('left') then
		self.dx = -PADDLE_SPEED
	elseif love.keyboard.isDown('right') then
		self.dx = PADDLE_SPEED
	else
		self.dx = 0
	end
	
	
	
	
	if self.dx < 0 then
        	self.x = math.max(0, self.x + self.dx * dt)
        else
        	self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    	end
end

function Paddle:render()
    love.graphics.draw(textures['main'], quads['paddles'][1],
        self.x, self.y)
end
