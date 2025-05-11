
-- Commented are defaults

function love.conf(tbl)
	local Global_setfenv = setfenv
	
	Global_setfenv(1, tbl)
	
	--identity = nil
	appendidentity = true
	version = '11.5'
	--console = false
	accelerometerjoystick = false
	--externalstorage = false
	gammacorrect = true
	
	--Global_setfenv(1, tbl.audio)
	
	--mic = false
	--mixwithsystem = true
	
	Global_setfenv(1, tbl.window)
	
	title = 'Snowy World'
	--icon = nil
	width = 0
	height = 0
	--borderless = false
	resizable = true
	--minwidth = 1
	--minheight = 1
	fullscreen = false
	--fullscreentype = 'desktop'
	vsync = 0
	--msaa = 0
	depth = 24
	--stencil = nil
	--display = 1
	--highdpi = false
	--usedpiscale = true
	--x = nil
	--y = nil
	
	Global_setfenv(1, tbl.modules)
	
	--audio = true
	--event = true
	--font = true
	--graphics = true
	--image = true
	joystick = false
	--keyboard = true
	--math = true
	--mouse = true
	physics = false
	--sound = true
	system = false
	thread = false
	--timer = true
	touch = false
	video = false
	--window = true
end
