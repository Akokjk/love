local loader = require "loader"
function love.load()
  --open file, put in content, break up on newline

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
  width, height = love.graphics.getDimensions()
  centerX = width/2;
  centerY = height/2;
  radius = (width > height and height/2-10 or width/2-10)
end



function love.draw()
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
