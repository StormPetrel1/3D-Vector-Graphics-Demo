
local Global_rawget = rawget
local Global_rawset = rawset

function exists(name)
	return Global_rawget(_G, name) ~= nil
end

function global(name, val)
	Global_rawset(_G, name, val or 0)
end

-- Secure global table
do
	local function errorUndeclared(_, name)
		error('attempt to access undeclared variable: ' .. name, 2)
	end
	
	setmetatable(_G, {
		__metatable = 'strict',
		__index = errorUndeclared,
		__newindex = errorUndeclared,
	})
end

function love.run()
	local Dispatch = require 'Dispatch'
	local State = require 'State'
	local Time = require 'Time'
	
	local Event_poll = love.event.poll
	local Event_pump = love.event.pump
	local Graphics_clear = love.graphics.clear
	local Graphics_isActive = love.graphics.isActive
	local Graphics_origin = love.graphics.origin
	local Graphics_present = love.graphics.present
	local Timer_sleep = love.timer.sleep
	local Timer_step = love.timer.step
	
	local Dispatch_Draw = Dispatch.Draw
	local Dispatch_Event = Dispatch.Event
	local Dispatch_Update = Dispatch.Update
	local Dispatch_call = Dispatch.call
	local Time_limitFPS = Time.limitFPS
	
	local sleep = 0
	
	-- Setup
	love.graphics.setDefaultFilter 'nearest'
	love.graphics.setDepthMode('less', true)
	love.graphics.setLineStyle 'rough'
	love.mouse.setRelativeMode(true)
	love.timer.step()
	
	return function()
		local State_scene = State.scene
		
		-- Handle events
		Event_pump()
		for name, a,b,c,d,e,f in Event_poll() do
			Dispatch_call(Dispatch_Event, name, State, a,b,c,d,e,f)
			if name == 'quit' then return a or 0 end
		end
		
		Dispatch_call(Dispatch_Update, State_scene, State)
		
		if Graphics_isActive() then
			Graphics_clear()
			Dispatch_call(Dispatch_Draw, State_scene, State)
			Graphics_present()
		end
		
		Time_limitFPS()
	end
end
