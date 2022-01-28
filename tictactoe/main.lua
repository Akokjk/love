
local loader = require "loader"
--local ltn12 = require("ltn12")
local https = require('ssl.https')
local lunajson = require 'lunajson'

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
  hearts = 3;
  score = 0;
  tempo= love.audio.newSource("tempo.mp3", "static")
  tempo:setLooping(true)
  --love.audio.play( tempo )
  loader.getWindowPos(Height, Width)
  love.window.setTitle("Trivia Beat")
  math.randomseed(os.time())
  sizeElements()
  debugFont = love.graphics.newFont("Roboto-Regular.ttf", 10,  "mono")
  love.graphics.setFont(mainFont)
  answers = {}
  --question = generateQuestion(love.math.random(140,  140), 30)
  question = {}
  question = formatQuestion(getQuestion(), question, 30)
  for i = 1, 6, 1 do
    answers[i] = generateQuestion(love.math.random(5,  40), 15)
    if i == 5 then
      answers[i][0] = 1
      answers[i][1] = hearts .. " Hearts"
    end
    if i == 6 then
      answers[i][0] = 1
      answers[i][1] = "Skip"
    end
  end
  --print("Info: " .. answers[1][1].."\n")

end


function sizeElements()
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
    questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeY*.28)/6),  "mono")
    answerFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeY*.05)),  "mono")
  else
    mainFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor(sizeX/50),  "mono")
    questionFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeX*.28)/6),  "mono")
    answerFont = love.graphics.newFont("Roboto-Regular.ttf", math.floor((sizeX*.05)),  "mono")
  end
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
      + (titleHieght - titleHieght/6 * question[0])/2) -- centers the text
      - (questionFont:getHeight()*(i-1)/question[0])/2  --divides text into sections based on line height and moves it half up the size
      + (questionFont:getHeight()*(i-1))) --puts text into correct divided sector
    end

    love.graphics.setFont(mainFont)



    --timer
    timerSize = sizeY*.02;

    love.graphics.rectangle("line", transXtop, transYtop + sizeY*.3, sizeX, timerSize)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", transXtop, transYtop + sizeY*.3, sizeX, timerSize)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print("Timer", transXtop, transYtop + sizeY*.3)


    --button box
    --love.graphics.print("Button Box", transXtop, transYtop + sizeY*.32)
    love.graphics.rectangle("line", transXtop , transYtop + sizeY*.32, sizeX, sizeY*.68)
    buttonBoxSize = sizeY*.68
    buttonBoxTop = transYtop + sizeY*.32
    love.graphics.setFont(answerFont)

    count = 1;

    for i = 0, 2, 1 do
      for c = 0, 1, 1 do
        love.graphics.setColor(1, 1, 1, 1)
        if count == 5 then
          love.graphics.setColor(0, 1, 0, 1)
        end
        if count == 6 then
          love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.rectangle("line", transXtop+sizeX/2*c, buttonBoxTop+ buttonBoxSize/3*i, sizeX/2, buttonBoxSize/3)
        --for x = 1, 6, 1 do
          for h = 1, answers[count][0], 1 do
            love.graphics.print(answers[count][h],
            transXtop+sizeX/2*c
            +sizeX/4
            - answerFont:getWidth(answers[count][h])/2,
            buttonBoxTop+ buttonBoxSize/3*i
            + questionFont:getHeight()*(h-1)
            + (buttonBoxSize/3-questionFont:getHeight()*answers[count][0])/2)
          end
        --end
        count = count + 1;
      end

    end


    --debug info
    love.graphics.setFont(debugFont)
    love.graphics.setColor(0, 0, 1, .5)
    love.graphics.rectangle("fill", width-100, height-100, 100, 100)
    love.graphics.setColor(1, 0, 0, .5)
    love.graphics.print(width .. " X " .. height, width-100, height-100) --resolution
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), width-100, height-90) -- fps
    love.graphics.print("Lines: "..tostring(question[0]), width-100, height-80) -- fps

end

function love.update(dt)

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
   sizeElements()
 end
end


function love.quit()
  loader.quit(love.window.getPosition())
end


function generateQuestion(num, length)
  qstring = ""

  for i = 0, num, 1 do
    if love.math.random(1,6) < 5 or i == 0 or i == num or qstring:sub(i-1,i-1) == " " then
      qstring = qstring .. "X"
    else
      qstring = qstring .. " "
    end
  end
  lines = {}
  lines[0] = 1
  --qstring = "What Touhou Project character's first ever appearance was as a midboss in the eighth game, Imperishable Night"
  return formatQuestion(qstring, lines, length)
end


function formatQuestion(qstring, lines, length)
  line_length = length;
  if string.len(qstring) >= line_length then -- could generalize the number of chracters by calculating based on how many characters i want to fit and how many rows.
    --print("Question length: " .. string.len(qstring))
    --print("Char at 1: " .. qstring:sub(1,1))
    for i = line_length+1, 1, -1 do
      if qstring:sub(i,i) == " " then
        --print("\nFound Space at index: " .. i)
        lines[lines[0]] = qstring:sub(1, i)
        qstring = qstring:sub(i+1, string.len(qstring))
        lines[0] = lines[0]+1
        formatQuestion(qstring, lines, length)
        break;
      end
    end
  else
    lines[lines[0]] = qstring
  end

  return lines
end


function getQuestion()
  https.TIMEOUT= 10
  link = 'https://opentdb.com/api.php?amount=1&type=multiple'
  resp = {}
  body, code, headers = https.request{
                                  url = link,
                                  headers = { ['Connection'] = 'close' },
                                  sink = ltn12.sink.table(resp)
                                   }
  if code~=200 then
      print("Error: ".. (code or '') )
      return
  end
  --print("Status:", body and "OK" or "FAILED")
  --print("HTTP code:", code)
  --print("Response headers:")
  -- if type(headers) == "table" then
  --   for k, v in pairs(headers) do
  --     print(k, ":", v)
  --   end
  -- end
  jsonparse = lunajson.decode(table.concat(resp), 31)

  return jsonparse["question"]
end
