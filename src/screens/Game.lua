local ScreenManager = require("lib.screen_manager")
local Screen = require("lib.screen")

local GameScreen = {}

function GameScreen.new()
  local self = Screen.new()

  local push = require("lib.push")

  local game = {}

  function self:init()
    game = love.graphics.newImage("assets/game-background.png", nil)
  end

  function self:update()
    Input:update()
    if Input:pressed("jump") then
      love.audio.stop(Music)
      ScreenManager.switch("menu")
    end
  end

  function self:draw()
    push:start()
    love.graphics.draw(game)
    push:finish()
  end

  return self
end

return GameScreen

