local push = require("lib.push")

local Buttons = Class:extend()
local Button = Class:extend()

function Buttons:new()
  self.list = {}
end

function Buttons:draw()
  for _, button in pairs(self.list) do
    button:draw()
  end
end

function Buttons:mousepressed(x, y)
  for _, button in pairs(self.list) do
    button:mousepressed(x, y)
  end
end

function Buttons:add(name, text, x, y, w, h)
  local button = Button(name, text, x, y, w, h)
  self.list[name] = button
end

function Buttons:addCentered(name, text, w, h)
  local width, height = push:getDimensions()
  local x = width / 2 - w / 2
  local y = height / 2 - h / 2
  self:add(name, text, x, y, w, h)
end

function Buttons:isPressed(name)
  return self.list[name].pressed
end

function Button:new(name, text, x, y, w, h)
  self.position = { x = x or 0, y = y or 0 }
  self.size = { x = w or 100, y = h or 50 }
  self.text = text or "Button"
  self.pressed = false
  self.name = name
end

local function drawCenteredText(rectX, rectY, rectWidth, rectHeight, text)
  local font = love.graphics.getFont()
  local textWidth = font:getWidth(text)
  local textHeight = font:getHeight()
  love.graphics.print(
      text, rectX + rectWidth / 2, rectY + rectHeight / 2, 0, 1, 1,
      textWidth / 2, textHeight / 2)
end

function Button:draw()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle(
      "fill", self.position.x, self.position.y, self.size.x, self.size.y)
  love.graphics.setColor(1, 1, 1, 1)
  drawCenteredText(
      self.position.x, self.position.y, self.size.x, self.size.y, self.text)
end

function Button:mousepressed(x, y)
  x, y = push:toGame(x, y)
  if x > self.position.x and x < self.position.x + self.size.x and y >
      self.position.y and y < self.position.y + self.size.y then
    self.pressed = true
  end
end

return Buttons
