local loader = require "loader"
function love.load()

  --config options
  Width = 1280
  Height = 720
  boundary = 10 -- number of pixels away from edge
  love.window.setMode(Width, Height, {
    fullscreen = false,
    vsync = 0,
    msaa = 0,
    stencil = true,
    depth = 0,
    resizable = true,
    borderless = false,
    centered = false,
    display = 1,
    minwidth = 1,
    minheight = 1
  })
  tempo= love.audio.newSource("tempo.mp3", "static")
  tempo:setLooping(true)
  --love.audio.play( tempo )
  loader.getWindowPos(Height, Width)
  love.window.setTitle("Trivia Beat")
  math.randomseed(os.time())
  width, height = love.graphics.getDimensions()
  if(width > height or height == width) then
    sizeX = height -boundary
    sizeY = height - boundary
  else
    sizeX = width -boundary
    sizeY = width -boundary
  end
  centerX = width/2;
  centerY = height/2;
  transXtop = centerX-sizeX/2
  transYtop = centerY-sizeY/2
  if sizeX > sizeY then
    mainFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor(sizeY/50),  "mono")
    questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeY*.3)/6),  "mono")
  else
    mainFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor(sizeX/50),  "mono")
    questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeY*.3)/6),  "mono")
  end

  love.graphics.setFont(mainFont)

  question = generateQuestion(love.math.random(6,  50))

end



function love.draw()


    love.graphics.clear( 29/255, 23/255, 23/255, 1, 0, false )
    love.graphics.setColor(255,255,255)


    --question goes here

    love.graphics.print("Title", centerX-sizeX/2, centerY-sizeY/2)
    love.graphics.rectangle("line", transXtop, transYtop, sizeX, sizeY)

    love.graphics.setFont(questionFont)
    titleHieght = sizeY*.3

    for i = 1, question[0], 1 do
      love.graphics.print(question[i],

        (transXtop --offset inside the box
      + sizeX/2 --center in box
      - questionFont:getWidth(question[i])/2), --center text by offsetting by half width

        (transYtop
      + (titleHieght - titleHieght/6 * lines[0])/2) -- centers the text
      - (questionFont:getHeight()*(i-1)/question[0])/2  --divides text into sections based on line height and moves it half up the size
      + (questionFont:getHeight()*(i-1))) --puts text into correct divided sector
    end

    love.graphics.setFont(mainFont)

    love.graphics.print("Button Box", transXtop, transYtop + sizeY/3)
    love.graphics.rectangle("line", transXtop , transYtop , sizeX, sizeY/3)

    --timer
    timerSize = sizeY/50;

    love.graphics.rectangle("line", transXtop, transYtop + sizeY/3 - timerSize, sizeX, timerSize)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", transXtop, transYtop + sizeY/3 - timerSize, sizeX, timerSize)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print("Timer", transXtop, transYtop + sizeY/3 - timerSize)


    --debug info

    love.graphics.print(width .. " X " .. height, transXtop + sizeX*.86, transYtop + sizeY*.97) --resolution
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), transXtop + sizeX*.86, transYtop + sizeY*.95) -- fps
    love.graphics.print("Lines: "..tostring(question[0]), transXtop + sizeX*.86, transYtop + sizeY*.93) -- fps

end

function love.update(dt)
  width, height = love.graphics.getDimensions()
 if love.graphics.getWidth() ~= Width or love.graphics.getHeight() ~= Height then
   if(width > height or height == width) then
     sizeX = height -boundary
     sizeY = height - boundary
   else
     sizeX = width -boundary
     sizeY = width -boundary
   end
   if sizeX > sizeY then
     mainFont = love.graphics.setNewFont("Roboto-Regular.ttf", sizeY/50, "mono")
   else
     mainFont = love.graphics.setNewFont("Roboto-Regular.ttf", sizeX/50, "mono")
   end
   Width = love.graphics.getWidth()
   Height = love.graphics.getHeight()
   centerX = width/2;
   centerY = height/2;

   if(width > height or height == width) then
     sizeX = height -boundary
     sizeY = height - boundary
   else
     sizeX = width -boundary
     sizeY = width -boundary
   end

   transXtop = centerX-sizeX/2
   transYtop = centerY-sizeY/2
   if sizeX > sizeY then
     mainFont = love.graphics.setNewFont("Roboto-Regular.ttf", math.floor(sizeY/50),  "mono")
     questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeY*.3)/6),  "mono")
   else
     mainFont = love.graphics.setNewFont("Roboto-Regular.ttf", math.floor(sizeX/50),  "mono")
     questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeY*.3)/6),  "mono")
   end
 end
end


function love.quit()
  loader.quit(love.window.getPosition())
end


function generateQuestion(num)
  qstring = ""
  for i = 0, num, 1 do
    if love.math.random(1,6) < 5 or i == 0 or i == num or qstring:sub(i,i) == " " then
      qstring = qstring .. "X"
    else
      qstring = qstring .. " "
    end
  end
  lines = {}
  lines[0] = 1
  return formatQuestion(qstring, lines)
end


function formatQuestion(qstring, lines)
  if string.len(qstring) > 30 then -- could generalize the number of chracters by calculating based on how many characters i want to fit and how many rows.
    print("Question length: " .. string.len(qstring))
    print("Char at 1: " .. qstring:sub(1,1))
    for i = 30, 1, -1 do
      if qstring:sub(i,i) == " " then
        print("\nFound Space at index: " .. i)
        lines[lines[0]] = qstring:sub(0, i)
        qstring = qstring:sub(i+1, string.len(qstring))
        lines[0] = lines[0]+1
        formatQuestion(qstring, lines)
      end
    end
  else
    lines[lines[0]] = qstring .. '?'
  end

  return lines
end
