LevelGenerator = Class{}

function LevelGenerator.generateLevel()
	local bricks = {}
	
	local rows = math.random(1, 5)
	local columns = math.random(8, 12)
	
	for y = 1, rows do
		for x = 1, columns do
			b = Brick((x - 1) * 32 + 8 + (13 - columns) * 16, y * 16)
			table.insert(bricks, b)
		end
	end
	
	
	if #bricks == 0 then
		return self.generateLevel()
	else
		return bricks
	end
end
