local ScreenManager = require("lib.screen_manager")
local Screen = require("lib.screen")

local GameScreen = {}

function GameScreen.new()
  local self = Screen.new()

  local push = require("lib.push")
  local Tilemapper = require("lib.tilemapper")
  local bump = require("lib.bump")
  local Player = require("src.entities.player")
  local Camera = require("lib.camera")
  local console = require("lib.console")
  require("src.debug")

  local camera = Camera(RES_X / 2, RES_Y / 2, RES_X, RES_Y)
  camera:setFollowStyle("PLATFORMER")

  local world = {}
  local map = {}
  local game = {}
  local player = {}

  local function init_level()
    player = Player(map.active.Entities.Player[1], world)
  end

  function self:init()
    game = love.graphics.newImage("assets/game-background.png", nil)
    map = Tilemapper(
              "assets/gamebase.ldtk",
              { aseprite = true, collisions = { [1] = true } })
    world = bump.newWorld()
    map:loadLevel("Level_0", world)
    camera:setBounds(0, 0, map.active.width, map.active.height)
    init_level()
  end

  function self:update(dt)
    Input:update()
    console.update(dt)
    if Input:pressed("cancel") then
      love.audio.stop(Music)
      ScreenManager.switch("menu")
    end
    if Input:pressed("fullscreen") then
      push:switchFullscreen()
    end
    if console.visible then
      return
    end
    player:update(dt)
    camera:follow(player.x, player.y)
    camera:update(dt)
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

  local function drawGame()
    map:draw()
    -- -- useful to debug collisions
    -- local items = world:getItems()
    -- for i = 1, #items do
    --   local item = items[i]
    --   if item.x and item.y and item.w and item.h then
    --     love.graphics.rectangle("line", item.x, item.y, item.w, item.h)
    --   end
    -- end
    player:draw()
  end

  local function drawBackground()
    love.graphics.draw(game)
  end

  local function drawUI()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Press 'Escape' to return to the menu.", 10, 10)
    console.draw()
  end

  function self:draw()
    push:start()
    love.graphics.clear()

    drawBackground()

    camera:attach()
    drawGame()
    camera:detach()
    camera:draw()

    drawUI()
    push:finish()
  end

  return self
end

return GameScreen

