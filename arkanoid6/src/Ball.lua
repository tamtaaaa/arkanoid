Ball = Class{}

function Ball:init(skin)
	self.width = 7
	self.height = 7
	
	self.dy = 0
	self.dx = 0
	
	self.skin = skin
end

function Ball:collides(target)
	if self.x > target.x + target.width or target.x > self.x + self.width then
		return false
	end
	
	if self.y > target.y + target.height or target.y > self.y + self.height then
		return false
	end
	
	sounds['hit']:play()
	return true
end

function Ball:reset()
	self.x = VIRTUAL_WIDTH / 2 - 3
	self.y = VIRTUAL_HEIGHT - 40
	
	self.dx = 0
	self.dy = 0
end


function Ball:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt

	if self.x <= 0 then
		sounds['hit']:play()
		self.x = 0
		self.dx = -self.dx
	end

	if self.x >= VIRTUAL_WIDTH - 8 then
		sounds['hit']:play()
		self.x = VIRTUAL_WIDTH - 8
		self.dx = -self.dx
	end

	if self.y <= 0 then
		sounds['hit']:play()
		self.y = 0
		self.dy = -self.dy
	end
end

function Ball:render()
	love.graphics.draw(textures['main'], quads['balls'][self.skin], self.x, self.y)
end