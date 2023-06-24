StartMenuState = Class{__includes = BaseState}

local hover = 1

function StartMenuState:update(dt)
	if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
		hover = hover == 1 and 2 or 1
	end
	
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
	
	
		if hover == 1 then
			stateMachine:change('serve', {
				paddle = Paddle(),
				health = 3,
				score = 0
			})
		else
			stateMachine:change('highscores', {
				
			})
		end
			
	end
	
	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function StartMenuState:render()
    love.graphics.setFont(fonts['large'])
    love.graphics.printf("ARKANOID", 0, VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(fonts['medium'])

    if hover == 1 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 40,
        VIRTUAL_WIDTH, 'center')

	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        
    if hover == 2 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 65,
        VIRTUAL_WIDTH, 'center')

	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end
