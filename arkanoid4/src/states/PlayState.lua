PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
	self.paddle = params.paddle
	self.bricks = params.bricks
	self.health = params.health
    	self.score = params.score
    	self.highscores = params.highscores
    	
    	self.ball = params.ball
    	
    	self.paused = false
    	
    	
	self.ball.dx = math.random(-200, 200)
	self.ball.dy = math.random(-50, -70)
end

function PlayState:update(dt)
	if self.paused then
		if love.keyboard.wasPressed('space') then
			self.paused = false
		else
			return
		end
	elseif love.keyboard.wasPressed('space') then
		self.paused = true
		return
	end
	
	self.paddle:update(dt)
	self.ball:update(dt)
	
	if self.ball:collides(self.paddle) then
		self.ball.y = self.paddle.y - self.ball.height
		self.ball.dy = -self.ball.dy
		
		if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
			self.ball.dx = -(7 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
		
		elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
			self.ball.dx = (7 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
		end
	end
	
	
	for k, brick in pairs(self.bricks) do
		if not brick.removed and self.ball:collides(brick) then
		
			brick:hit()
			
			if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
				self.ball.dx = -self.ball.dx
				self.ball.x = brick.x - self.ball.width
			
			elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
				
				self.ball.dx = -self.ball.dx
				self.ball.x = brick.x + brick.width
			
			elseif self.ball.y < brick.y then
				
				self.ball.dy = -self.ball.dy
				self.ball.y = brick.y - self.ball.width
			
			else
				
				self.ball.dy = -self.ball.dy
				self.ball.y = brick.y + brick.height
			end
			
			self.ball.dy = self.ball.dy * 1.05
			
			break
		end
			
			
	end
	
	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
	
end

function PlayState:render()
	for k, brick in pairs(self.bricks) do
		brick:render()
	end
	
	self.ball:render()
	
	self.paddle:render()
	
end
