local ScreenManager = require("lib.screen_manager")
local Screen = require("lib.screen")

local MenuScreen = {}

function MenuScreen.new()
  local self = Screen.new()

  local push = require("lib.push")
  local UI = require("lib.ui.core")

  local Buttons = UI.Buttons()

  local menu = {}

  function self:init()
    menu = love.graphics.newImage("assets/menu-background.png", nil)
    Buttons:addCentered("start", "Click here to start", 120, 50)
  end

  function self:update()
    if Buttons:isPressed("start") then
      love.audio.stop(Music)
      ScreenManager.switch("game")
    end
  end

  function self:draw()
    push:start()
    love.graphics.draw(menu)
    Buttons:draw()
    push:finish()
  end

  function self:mousepressed(x, y)
    Buttons:mousepressed(x, y)
  end

  return self
end

return MenuScreen
