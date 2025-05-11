
local Ent = require 'Ent'
local Graphics = require 'Graphics'

local State = {
	Ent = {},
	
	Graphics = {
		
	},
	
	World = {
		x = 0,
		y = 0,
	},
	
	scene = 'demo',
}

Ent.add(State.Ent, {
	x = -10,
	y = -10,
	z = -10,
	angleHorizon = 0,
	angleVertical = 0,
}, Ent.PlayerType)

return State
