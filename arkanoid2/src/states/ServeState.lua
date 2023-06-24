ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
	self.paused = false

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
end

function ServeState:render()
	self.paddle:render()
	self.ball:render()
end
