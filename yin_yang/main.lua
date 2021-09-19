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
  loader.getWindowPos(love.window.getPosition())
  love.window.setTitle("Yin Yang")
  math.randomseed(os.time())

end



function love.draw()


    love.graphics.print("Testing 123", 400, 300)


end

function love.quit()
  loader.quit(love.window.getPosition())
end
