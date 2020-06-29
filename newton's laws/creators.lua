function createStatic(label,x,y,w,h)
  local static = {}
  static.b = love.physics.newBody(World, x,y, "static")
  static.s = love.physics.newRectangleShape(w,h)
  static.f = love.physics.newFixture(static.b, static.s)
  static.f:setUserData(label)
  return static
end

function createWalls()
  local walls = {}
  walls[1] = createStatic("wall", screenW/2,-16 ,screenW,32)
  walls[2] = createStatic("wall", -16,screenH/2 ,32,screenH)
  walls[3] = createStatic("wall", screenW/2,screenH+16 ,screenW,32)
  walls[4] = createStatic("wall", screenW+16,screenH/2 ,32,screenH)
  return walls
end

function createRect(x,y,w,h)
  local rect = {}
  rect.b = love.physics.newBody(World, x,y, "dynamic")
  rect.s = love.physics.newRectangleShape(w,h)
  rect.f = love.physics.newFixture(rect.b, rect.s)
  rect.f:setUserData("Rect")
  rect.b:setMass(10)
  function rect:getVelocity()
    local vecX, vecY = self.b:getLinearVelocity()
    return vecX, vecY, math.sqrt(vecX*vecX+vecY*vecY)
  end
  function rect:getForce()
    local acel = math.sqrt(acelX*acelX+acelY*acelY)
    local mass = self.b:getMass()
    return acelX/1000*mass, acelY/1000*mass, acel/1000*mass
  end
  return rect
end
