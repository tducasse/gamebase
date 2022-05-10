local peachy = require("lib.peachy")

local Player = Class:extend()

function Player:update(dt)
  self.sprite:update(dt)

  local x, y = self.x, self.y
  local x_axis = Input:get("move")

  if math.abs(self.x_velocity) > 10 then
    self.x_velocity = self.x_velocity - self.last_dir * self.friction
  else
    self.x_velocity = 0
  end

  if x_axis > 0 then
    self.x_velocity = self.speed
    self.next_tag = "Idle"
    self.last_dir = 1
  elseif x_axis < 0 then
    self.x_velocity = -self.speed
    self.next_tag = "Idle"
    self.last_dir = -1
  else
    self.next_tag = "Idle"
  end

  if Input:down("jump") then
    if self.ground and not self.jumping then
      self.jumping = true
      self.y_velocity = self.jump_height
    end
  end

  if Input:released("jump") then
    self.jumping = false
  end

  x = self.x + self.x_velocity * dt + 0.000001
  y = self.y + self.y_velocity * dt + 0.000001
  self.y_velocity = self.y_velocity + self.gravity * dt

  local cols
  self.x, self.y, cols = self.world:move(self, x, y, self.filter)

  local ground = false
  for _, col in pairs(cols) do
    if col.normal.y == 1 then
      self.y_velocity = 0
    elseif col.normal.y == -1 then
      ground = true
      self.y_velocity = 0
    end
  end

  self.ground = ground

  if not self.ground then
    self.next_tag = "Jump"
  end

  self.sprite:setTag(self.next_tag)
end

function Player:draw()
  local left = self.left or 0
  local top = self.top or 0
  local x = self.x - left
  local y = self.y - top
  if self.last_dir == -1 then
    x = x + self.w + left * 2
  end
  self.sprite:draw(x, y, 0, self.last_dir)
end

function Player:new(p, world)
  self.type = "player"
  -- POSITION
  self.x = p.x
  self.y = p.y
  self.top = p.top
  self.left = p.left
  self.w = p.w
  self.h = p.h

  -- PHYSICS
  self.speed = 50
  self.friction = 5
  self.ground = false
  self.jump_height = -93
  self.gravity = 180
  self.jumping = false
  self.y_velocity = 0
  self.x_velocity = 0

  -- DRAWING
  self.sprite = peachy.new(
                    "assets/player.json",
                    love.graphics.newImage("assets/player.png", nil), "Idle")
  self.last_dir = 1
  self.sprite:play()

  self.world = world
  self.world:add(self, self.x, self.y, self.w, self.h)
end

return Player
