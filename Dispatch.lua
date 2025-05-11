
-- This is a central hub of control flow, try to keep dependency low

local Ent = require 'Ent'
local Graphics = require 'Graphics'
local World = require 'World'

local Ent_updateAll = Ent.updateAll
local Graphics_draw3D = Graphics.draw3D
local Graphics_update3D = Graphics.update3D
local WORLD_TERRA = World.TERRA

return {
	Draw = {
		demo = function(State)
			Graphics_update3D(State.Ent[1])
			Graphics_draw3D(WORLD_TERRA)
		end,
	},
	
	Event = {
		mousemoved = function(State, x, y, dx, dy)
			local player = State.Ent[1]
			
			player.angleHorizon = player.angleHorizon - dx * (1/1536)
			player.angleVertical = player.angleVertical - dy * (1/1536)
			
			return player
		end,
	},
	
	Update = {
		demo = function(State)
			State.Ent = Ent_updateAll(State.Ent)
			return State
		end,
	},
	
	call = function(tbl, name, ...)
		local fn = tbl[name]
		return fn and fn(...) or ...
	end,
}
