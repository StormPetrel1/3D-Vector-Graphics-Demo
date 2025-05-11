
local Math_ceil = math.ceil
local Math_noise = love.math.noise

local function coordToIdx(x, y, sizeX)
	local y = Math_ceil(idx / sizeX)
	local x = idx - (y - 1) * sizeX
	return (y - 1) * sizeX + x
end

local function idxToCoord(idx, sizeX)
	local y = Math_ceil(idx / sizeX)
	local x = idx - (y - 1) * sizeX
	return x, y
end

local function genHillHeight(x, z)
	return Math_noise(x * (1/1024), z * (1/1024)) * 750--1024
end

--[[ Hill generator
(function(vertices)
	local function pale() return 0.6, 0.6, 0.4 end
	local function red() return 0.6, 0.6, 0.4 end
	local function white() return 0.85, 0.85, 0.8 end
	
	return {
		{-100,-400,-100, pale()},
		{-150,0,-50, pale()},
		{-100,-400,0, pale()},
		{-50,0,-50, pale()},
		{0,-400,0, pale()},
		{50,0,50, pale()},
	}
end){},

(function(vertices)
	local Math_random = math.random
	local Table_insert = table.insert
	
	local alternator = 1
	for x = -2500, 2500, 16 do
		for z = -2500 * alternator, 2500 * alternator, 16 do
			local y = genHillHeight(x, z)
			
			local shade = (y + 128) * (1/1280) + Math_random() * (1/8)
			Table_insert(vertices, {
				x, y, z, shade, shade, shade,
			})
		end
		alternator = alternator * -1
	end
	
	return vertices
end){},
--]]

--[[
mesh:setVertexMap((function(vertexMap)
	local Table_insert = table.insert
	
	for i = 1, mesh:getVertexCount() - sizeX do
		-- Triangle mode? (for loop step 2)
		-- Poly 1
		Table_insert(vertexMap, i)
		Table_insert(vertexMap, i + 1)
		Table_insert(vertexMap, i + sizeX)
		-- Poly 2
		Table_insert(vertexMap, i + 1)
		Table_insert(vertexMap, i + sizeX)
		Table_insert(vertexMap, i + sizeX - 1)
		
		-- Alternate method: triangle strip mode?
		Table_insert(vertexMap, i)
		Table_insert(vertexMap, i + sizeX)
	end
	
	return vertexMap
end){})
--]]

return {
	TERRA = (function()
		local sizeX = 800
		
		local mesh = love.graphics.newMesh(
			{
				{'VertexPosition', 'float', 3},
				--{'VertexTexCoord', 'float', 2},
				{'VertexColor', 'float', 3},
			},
			(function(vertices)
				local Math_random = math.random
				
				for i = 1, sizeX * sizeX do
					local gridX, gridZ = idxToCoord(i, sizeX)
					local worldX, worldZ = gridX * 8, gridZ * 8
					
					local worldY = genHillHeight(worldX, worldZ)
					
					local shade = (worldY + 128) * (1/1024) + Math_random() * (1/24)
					
					vertices[i] = {
						worldX, worldY, worldZ, shade, shade, shade,
					}
				end
				
				return vertices
			end){},
			'strip',
			'static'
		)
		
		mesh:setVertexMap((function(vertexMap)
			local Math_max = math.max
			local Table_insert = table.insert
			
			local count = mesh:getVertexCount() - sizeX
			local start, stop, step = 1, sizeX, 1
			while stop <= count do
				for i = start, stop, step do
					Table_insert(vertexMap, i)
					Table_insert(vertexMap, i + sizeX)
				end
				
				start, stop, step = stop + sizeX, start + sizeX, step * -1
			end
			
			return vertexMap
		end){})
		
		return mesh
	end)(),
}
