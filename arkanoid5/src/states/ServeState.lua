ServeState = Class{__includes = BaseState}

function ServeState:enter(params)

	self.paddle = params.paddle
	self.bricks = params.bricks
	self.health = params.health
	self.score = params.score
	self.highscores = params.highscores
	
	self.ball = Ball(1)
end

function ServeState:update(dt)
	
	self.paddle:update(dt)
	
	self.ball.x = self.paddle.x + (self.paddle.width / 2) - 3
	self.ball.y = self.paddle.y - 8
	
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		stateMachine:change('play', {
			paddle = self.paddle,
			bricks = self.bricks,
			health = self.health,
			ball = self.ball,
			score = self.score,
			highscores = self.highscores
		})
	end
	
end

function ServeState:render()
	for k, brick in pairs(self.bricks) do
		brick:render()
	end
	
	renderScore(self.score)
	renderHealth(self.health)

	self.paddle:render()
	self.ball:render()
end


