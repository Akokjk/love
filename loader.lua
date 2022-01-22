
--opens data and grabs saved pos data from when window was last open
--also can save to file when you quit game
local loader = {}

function loader.getWindowPos(height, width )
  data = io.open("data", "r+")
  io.input(data)
  win_x = tonumber(io.read()); -- if you do io.read it automatically moves to the next line
  if(win_x == nil) then
    io.output(data)
    local x, y, dispindex = love.window.getPosition() -- lol so happy i can refer to this in this scope
    io.write(x .. "\n" .. y)
  else
    win_y = tonumber(io.read());
    if(win_x > width*.8 or win_y > height*.8 or win_x == 0 or win_y == 0) then
      love.window.setPosition(50, 50, 1)
    else
      love.window.setPosition(win_x, win_y, 1)
    end
  end
  data:close()
end

function loader.quit()
  data = io.open("data", "w"):close()
  io.output(data)
  local x, y, dispindex = love.window.getPosition()
  io.write(x .. "\n" .. y)
  io.close(data)
end

return loader
