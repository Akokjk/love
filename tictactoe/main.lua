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
  if sizeX > sizeY then
    mainFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor(sizeY/50),  "mono")
    questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeY*.3)/6),  "mono")
  else
    mainFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor(sizeX/50),  "mono")
    questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeX*.3)/6),  "mono")
  end

  love.graphics.setFont(mainFont)
  question = generateQuestion(love.math.random(6,  150))
end



function love.draw()


    love.graphics.clear( 29/255, 23/255, 23/255, 1, 0, false )
    love.graphics.setColor(255,255,255)
    --love.graphics.print("Tic Tac Toe by Akokjk", 10, 10)
    --so get the size of the screen if x:y then closer to 16:9 make x bigger visa versa
    width, height = love.graphics.getDimensions()
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

    --question goes here

    love.graphics.print("Title", centerX-sizeX/2, centerY-sizeY/2)
    love.graphics.rectangle("line", transXtop, transYtop, sizeX, sizeY)

    love.graphics.setFont(questionFont)
    love.graphics.print(question, transXtop, transYtop)
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

    love.graphics.print(width .. " X " .. height, transXtop + sizeX*.86, transYtop + sizeY*.98) --resolution
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), transXtop + sizeX*.86, transYtop + sizeY*.95) -- fps


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
  question = ""
  for i = 0, num, 1 do
    if love.math.random(0,1) == 1 then
      question = question .. "X"
    else
      question = question .. "O"
    end
  end
  return question .. "?"
end
