GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
	self.score = params.score
	self.highscores = params.highscores
end

function GameOverState:update(dt)
	
end
