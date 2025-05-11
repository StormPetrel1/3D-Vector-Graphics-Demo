
local Shader3D = love.graphics.newShader 'Shader3D.glsl'

local Coroutine_yeild = coroutine.yield
local Graphics_draw = love.graphics.draw
local Graphics_getHeight = love.graphics.getHeight
local Graphics_getWidth = love.graphics.getWidth
local Graphics_scale = love.graphics.scale
local Graphics_scissor = love.graphics.setScissor
local Graphics_shade = love.graphics.setShader
local Graphics_translate = love.graphics.translate
local Math_cos = math.cos
local Math_sin = math.sin

--local W, H = 480, 270

return {
	draw3D = function(mesh)
		Graphics_shade(Shader3D)
		Graphics_draw(mesh)
		Graphics_shade()
	end,
	
	update3D = function(player)
		local angleHorizon = player.angleHorizon
		local angleVertical = player.angleVertical
		
		-- stackoverflow.com/questions/30011741/3d-vector-defined-by-2-angles
		local cosVertical = Math_cos(angleVertical)
		local lookY = Math_sin(angleVertical)
		
		local lookX = Math_sin(angleHorizon) * cosVertical
		local lookZ = Math_cos(angleHorizon) * cosVertical
		
		Shader3D:send('look', {lookX, lookY, lookZ})
		Shader3D:send('origin', {player.x, player.y, player.z})
	end
}
