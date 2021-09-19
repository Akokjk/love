function love.load()
  loader()
  love.window.setMode(200, 200, {
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
    minheight = 1,
    x = win_x,
    y = win_y
  })
  love.window.setTitle("Static Noise")
  math.randomseed(os.time())
end

--opens data, checks to see if its empty if not move the window to saved position
function loader()
  data = io.open("static_noise/data", "r+")
  io.input(data)
  win_x = io.read(); -- if you do io.read it automatically moves to the next line
  if(win_x == nil) then
    io.output(data)
    local x, y, dispindex = love.window.getPosition()
    io.write(x .. "\n" .. y)
  else
    win_y = io.read();
  end
end

function love.draw()
    --first thing todo is remember where window was
    --arrays start at 1 in lua :D

    -- love.graphics.print("Testing 123", 400, 300)
    width, height = love.graphics.getDimensions( )
    --create a buffer to hold static images of a certain size then loop through
    for  x=0, width, 1 do
      for  y=0, height, 1 do
          love.graphics.setColor(love.math.random(0, 5), love.math.random(0, 1), love.math.random(0, 1))
          love.graphics.points(x, y)
      end
    end

    -- love.graphics.setColor(255,255,255)
    -- love.graphics.rectangle("fill", 20,50, 60,120)
    -- love.graphics.print(win_x .. "\n" .. win_y, 300, 300)
end

function love.quit()
  data:seek("set")
  io.output(data)
  local x, y, dispindex = love.window.getPosition()
  io.write(x .. "\n" .. y)
  io.close(data)
end
