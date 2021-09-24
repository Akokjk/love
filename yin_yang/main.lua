local loader = require "loader"
function love.load()

  --config options
  love.window.setMode(500, 500, {
    fullscreen = false,
    vsync = 0,
    msaa = 0,
    stencil = true,
    depth = 0,
    resizable = false,
    borderless = false,
    centered = false,
    display = 1,
    minwidth = 1,
    minheight = 1
  })
  loader.getWindowPos()
  love.window.setTitle("Yin Yang")
  math.randomseed(os.time())

  --project related varibles
  width, height = love.graphics.getDimensions()
  centerX = width/2; 
  centerY = height/2;
  radius = (width > height and height/2-10 or width/2-10)
end



function love.draw()

    --basically creating a yin yang in code can be done in a couple of steps
    --[[
      1. Draw a half white circle with size radius from 0 to pi
      2. draw a half black circle with size radius from pi to 2 pi
      3. draw a half black circle with size radius/2 at the center minus half the radius
      4. repeat step 3 with a half white circle on other side
      5. Add a 1/8 radius circle in at center +- radius*2
    --]]
    love.graphics.clear( 29/255, 23/255, 23/255, 1, 0, false )
    love.graphics.setColor(255,255,255)
    love.graphics.print("Yin Yang by Akokjk", 10, 10)
    love.graphics.arc( "fill", centerX, centerY, radius, math.pi, 2*math.pi, 20 )

    love.graphics.setColor(0,0,0)
    love.graphics.arc( "fill", centerX-radius/2, centerY, radius/2, math.pi, 2*math.pi, 20 )
    love.graphics.arc( "fill", centerX, centerY, radius, -math.pi, -2*math.pi, 20 )
    love.graphics.setColor(255,255,255)
    love.graphics.arc( "fill", centerX+radius/2, centerY, radius/2, -math.pi, -2*math.pi, 20 )
    love.graphics.circle( "fill", centerX-radius/2, centerY, radius/8 )
    love.graphics.setColor(0,0,0)
    love.graphics.circle( "fill", centerX+radius/2, centerY, radius/8 )
    --love.graphics.circle("fill", centerX+(width/2-10)/2, centerY, (width/2-10)/2)
    --love.graphics.circle("fill", centerX-(width/2-10)/2, centerY, (width/2-10)/2)



end

function love.quit()
  loader.quit(love.window.getPosition())
end
