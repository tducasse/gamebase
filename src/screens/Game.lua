local ScreenManager = require("lib.screen_manager")
local Screen = require("lib.screen")

local GameScreen = {}

function GameScreen.new()
  local self = Screen.new()

  local push = require("lib.push")
  local Tilemapper = require("lib.tilemapper")
  local bump = require("lib.bump")
  local Player = require("src.entities.player")

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
    init_level()
  end

  function self:update(dt)
    Input:update()
    if Input:pressed("cancel") then
      love.audio.stop(Music)
      ScreenManager.switch("menu")
    end
    player:update(dt)
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
    player:draw()
    push:finish()
  end

  return self
end

return GameScreen

