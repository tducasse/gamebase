if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
  require("lldebugger").start()
end
local push = require("lib.push")
local ScreenManager = require("lib.screen_manager")
local baton = require("lib.baton")
local inspect = require("lib.inspect")
require("lib.audio")

Class = require("lib.classic")
Signal = require("lib.signal")
Music = {}

RES_X = 384
RES_Y = 216
WIN_X = 768
WIN_Y = WIN_X / (RES_X / RES_Y)

Inspect = function(a, options)
  print(inspect(a, options))
end

function love.load()
  Input = baton.new {
    controls = {
      left = { "key:left", "key:a" },
      right = { "key:right", "key:d" },
      up = { "key:up", "key:w" },
      down = { "key:down", "key:s" },
      jump = { "key:space", "key:z" },
      shoot = { "key:j", "key:x" },
      cancel = { "key:escape" },
    },
    pairs = { move = { "left", "right", "up", "down" } },
  }

  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setLineStyle("rough")

  push:setupScreen(
      RES_X, RES_Y, WIN_X, WIN_Y, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false,
        pixelperfect = true,
      })

  local screens = {
    game = require("src.screens.Game"),
    menu = require("src.screens.Menu"),
  }
  ScreenManager.init(screens, "menu")
  ScreenManager.registerCallbacks()
end

function love.resize(w, h)
  return push:resize(w, h)
end
