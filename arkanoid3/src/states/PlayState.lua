PlayState = Class{__includes = BaseState}

function PlayState:init(params)
	self.paddle = params.paddle
	self.bricks = params.bricks
	self.health = params.health
    	self.score = params.score
    	self.highscores = params.highscores
    	
    	self.ball = parrams.ball
    	
    	self.paused = false
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
	
	
	for k, brick in pairs(self.bricks) do
		if not brick.removed and self.ball:collides(brick) then
		
			self.score = self.score(200)
			brick:hit()
			
			
	end
	
end
