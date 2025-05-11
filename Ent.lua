
local Global_setMT = setmetatable
local Key_isDown = love.keyboard.isDown
local Math_cos = math.cos
local Math_sin = math.sin
local Table_insert = table.insert

--local HALF_PI = math.pi * 0.5
local MOVE_SPEED = 16

local bnum = (function(lookup)
	return function(bool) return lookup[bool] end
end){[false] = 0, [true] = 1}

local function movePlayer(player)
	local angleHorizon = player.angleHorizon
	local move = (bnum(Key_isDown 'w') - bnum(Key_isDown 's')) * MOVE_SPEED
	
	player.x = player.x + Math_sin(angleHorizon) * move
	player.y = player.y +
		(bnum(Key_isDown 'e') - bnum(Key_isDown 'q')) * MOVE_SPEED
	player.z = player.z + Math_cos(angleHorizon) * move
	
	return player
end

return {
	PlayerType = {
		__index = {
			-- Constants
			
			-- Defaults
			
		},
	},
	
	add = function(State_Ent, ent, entType)
		Table_insert(State_Ent, entType and Global_setMT(ent, entType) or ent)
		return State_Ent
	end,
	
	updateAll = function(State_Ent)
		State_Ent[1] = movePlayer(State_Ent[1])
		return State_Ent
	end,
}
