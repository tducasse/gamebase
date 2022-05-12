local ScreenManager = require("lib.screen_manager")
local Screen = require("lib.screen")

local MenuScreen = {}

function MenuScreen.new()
  local self = Screen.new()

  local push = require("lib.push")
  local UI = require("lib.ui.core")
  local console = require("lib.console")
  require("src.debug")

  local Buttons = UI.Buttons()

  local menu = {}

  function self:init()
    menu = love.graphics.newImage("assets/menu-background.png", nil)
    Buttons:addCentered("start", "Click here to start", 120, 50)
  end

  function self:update(dt)
    Input:update()
    console.update(dt)
    if Buttons:isPressed("start") then
      love.audio.stop(Music)
      ScreenManager.switch("game")
    end
    if Input:pressed("fullscreen") then
      push:switchFullscreen()
    end
  end

  function self:draw()
    push:start()
    love.graphics.draw(menu)
    Buttons:draw()
    console.draw()
    push:finish()
  end

  function self:mousepressed(x, y, button)
    Buttons:mousepressed(x, y)
  end

  function self:keypressed(key)
    if console.keypressed(key) then
      return
    end
  end

  function self:textinput(text)
    if console.textinput(text) then
      return
    end
  end

  function self:resize(w, h)
    console.resize(w, h)
  end

  return self
end

return MenuScreen
