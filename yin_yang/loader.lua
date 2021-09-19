local loader = {}

function loader.getWindowPos()
  data = io.open("yin_yang/data", "r+")
  io.input(data)
  win_x = io.read(); -- if you do io.read it automatically moves to the next line
  if(win_x == nil) then
    io.output(data)
    local x, y, dispindex = love.window.getPosition()
    io.write(x .. "\n" .. y)
  else
    win_y = io.read();
    love.window.setPosition(win_x, win_y, 1)
  end
end

function loader.quit()
  data:seek("set")
  io.output(data)
  local x, y, dispindex = love.window.getPosition()
  io.write(x .. "\n" .. y)
  io.close(data)
end

return loader