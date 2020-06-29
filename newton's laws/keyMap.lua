local callbacks = {}

callbacks["d"] = function() Debug = not Debug end

callbacks["v"] = function()
  rect1.b:setMass(rect1.b:getMass()+1)
end

callbacks["b"] = function()
  rect1.b:setMass(rect1.b:getMass()-1)
end

callbacks["space"] = function() reset() end

callbacks["escape"] = function() love.event.push('quit') end

return callbacks
