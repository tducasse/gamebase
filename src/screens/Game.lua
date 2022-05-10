local ScreenManager = require("lib.screen_manager")
local Screen = require("lib.screen")

local GameScreen = {}

function GameScreen.new()
  local self = Screen.new()

  local push = require("lib.push")
  local Tilemapper = require("lib.tilemapper")
  local bump = require("lib.bump")

  local world = {}
  local map = {}
  local game = {}

  function self:init()
    game = love.graphics.newImage("assets/game-background.png", nil)
    map = Tilemapper(
              "assets/gamebase.ldtk",
              { aseprite = true, collisions = { [1] = true } })
    world = bump.newWorld()
    map:loadLevel("Level_0", world)
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
    map:draw()
    -- -- useful to debug collisions
    -- local items = world:getItems()
    -- for i = 1, #items do
    --   local item = items[i]
    --   if item.x and item.y and item.w and item.h then
    --     love.graphics.rectangle("line", item.x, item.y, item.w, item.h)
    --   end
    -- end
    push:finish()
  end

  return self
end

return GameScreen

