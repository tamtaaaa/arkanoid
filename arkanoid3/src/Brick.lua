Brick = Class{}

function Brick:init(x, y)
	self.x = x
	self.y = y
	self.width = 32
	self.height = 9
	
	self.removed = false
end

function Brick:render()
	if not self.removed then
		love.graphics.draw(textures['bricks'], quads['bricks'][4], self.x, self.y)
	end
end
