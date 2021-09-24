local loader = require "loader"
function love.load()
  --config options
  screen_x = 600
  screen_y = 600
  love.window.setMode(screen_x, screen_y, {
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
  love.window.setTitle("Game Jam: Shapeshift")
  math.randomseed(os.time())
  --project related varibles
  width, height = love.graphics.getDimensions()
  centerX = width/2;
  centerY = height/2;
  radius_max = (width > height and height/2-10 or width/2-10)
  radius = 10 -- intial radius
  rate_of_expansion = 1 -- 1 pixel per frame
  num_of_points = 30 -- creates a series of points on the edge of the shape to propagate and interact with other elements
  points = {}
  point_vectors = {}
end

function love.draw()
    --generate a radius based on the length of a click
    --generate a random number of points 3,4,5,6,7,8 on the edge of the circle
    --draw a polygon from the points
    -- draw lines connecting each point
    -- at a given rate expand the orginal radius and recaluclate where the orignal points would go on the new circle and draw new lines connecting them
    -- do this at multiple intervals expanding until it reachs the edge of the visible area on the screen
    love.graphics.clear( 29/255, 23/255, 23/255, 1, 0, false )
    love.graphics.setColor(255,255,255)
    --love.graphics.circle( "fill", centerX, centerY, radius )
    love.graphics.print("Shape Shift by Akokjk", 10, 10)
    if points[1] ~= nil then
      --love.graphics.print(points[1][2] or "idk", 10, 25)
      love.graphics.polygon("line", get_points())
    end
    --love.graphics.print(points[1][1] or "idk", 10, 25)
    love.graphics.points(points)



end

function get_points()
  pointslist = {}
  for i = 1, num_of_points do
    table.insert(pointslist, points[i][1])
    table.insert(pointslist, points[i][2])
  end
  return pointslist
end

function love.update(dt)

    for i=1, num_of_points do
      if points[i] ~= nil then
        points[i] = {points[i][1] + math.cos(point_vectors[i])*rate_of_expansion, points[i][2] + math.sin(point_vectors[i])*rate_of_expansion}
        if(points[i][1] <= 0 or points[i][1] >= screen_x) then
          point_vectors[i] = point_vectors[i] + math.pi
        end
        if(points[i][2] <= 0 or points[i][2] >= screen_y) then
          point_vectors[i] = point_vectors[i] + math.pi
        end

      end
    end

  if love.mouse.isDown(1) then
	   radius = ((radius < radius_max) and rate_of_expansion + radius) or radius_max
     reset_points();
	end
  if love.mouse.isDown(2) then
     radius =  ((radius > 10) and radius - rate_of_expansion) or 10
     reset_points();
  end
end

function reset_points()
--math source:  https://www.dummies.com/education/math/trigonometry/use-coordinates-of-points-to-find-values-of-trigonometry-functions/
  for i=1, num_of_points do
    angle = (2 * math.pi)/num_of_points * i
    point_vectors[i] = angle
    points[i] = { (math.cos(angle) * radius) + centerX, (math.sin(angle) * radius)+centerY}
  end
end

function love.quit()
  loader.quit(love.window.getPosition())
end
