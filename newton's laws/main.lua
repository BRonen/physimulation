local keyCallback = require 'keyMap'
require 'creators'
Debug = false

screenW, screenH = love.graphics.getDimensions()
acelX, acelY = 0, 0

function love.load(args)
  love.window.setTitle("Physimulator")
  love.physics.setMeter(32)
  
  World = love.physics.newWorld()
  World:setCallbacks(beginContact,nihil,nihil,nihil)

  Walls = createWalls()
  
  rect1 = createRect(320,320 ,32,32)
  rect2 = createRect(640,320 ,32,32)
end

function love.update(dt)
  rect1.b:setAngle(0)
  rect2.b:setAngle(0)
  acelX, acelY = 0,0
  if love.keyboard.isDown("space") then
    rect1.b:setLinearVelocity(0,0)
  end
  if love.keyboard.isDown("right") then
    acelX = 64000
  end
  if love.keyboard.isDown("left") then
    acelX = -64000
  end
  if love.keyboard.isDown("up") then
    acelY = -64000
  end
  if love.keyboard.isDown("down") then
    acelY = 64000
  end
  rect1.b:applyForce(acelX*dt, acelY*dt)
  World:update(dt)
end

function love.draw()

  love.graphics.polygon("line", rect1.b:getWorldPoints(rect1.s:getPoints()))
  love.graphics.print(string.format('Velocity = x> %d y> %d total> %d', rect1:getVelocity()), screenW/5, 74)
  love.graphics.print(string.format('Mass = %d', rect1.b:getMass()), screenW/2, 74)
  love.graphics.print(string.format('Force = x> %d y> %d total> %d', rect1:getForce()), screenW/5, 90)
  
  love.graphics.polygon("fill", rect2.b:getWorldPoints(rect2.s:getPoints()))
  love.graphics.print(string.format('Velocity = x> %d y> %d total> %d', rect2:getVelocity()), screenW/5, 126)
  love.graphics.print(string.format('Mass = %d', rect2.b:getMass()), screenW/2, 126)
  love.graphics.print(string.format('Force = x> %d y> %d total> %d', rect2:getForce()), screenW/5, 142)
  
  for i=1, #Walls do
    love.graphics.polygon("line", Walls[i].b:getWorldPoints(Walls[i].s:getPoints()))
  end
  love.graphics.print('Use arrows to apply force in rect.', screenW/3, 32)
  love.graphics.print('Use space to reset rects and [v][b] to set mass.', screenW/4, 48)
  
  if Debug then
    love.graphics.print('FPS: ' .. love.timer.getFPS(), 8, 8)
    love.graphics.print('Memory usage: ' .. math.floor(collectgarbage "count") .. 'kb', 8, 24)
  end
end

function love.keypressed(key)
  if keyCallback[key] then keyCallback[key](love.timer.getDelta()) end
end

function beginContact(a, b, coll)
  print(a:getUserData(),'->', 'collided with', '->', b:getUserData())
end

function reset()
  rect1.b:setPosition(320,320)
  rect2.b:setPosition(640,320)
  rect1.b:setLinearVelocity(0,0)
  rect2.b:setLinearVelocity(0,0)
  rect1.b:setAngularVelocity(0,0)
  rect2.b:setAngularVelocity(0,0)
end

function nihil() return nil end
