
local Timer_sleep = love.timer.sleep
local Timer_step = love.timer.step

local TARGET_DELTA = 1/60

return {
	limitFPS = (function(sleep) return function()
		sleep = sleep + TARGET_DELTA - Timer_step()
		Timer_sleep(sleep)
	end end)(0),
}
