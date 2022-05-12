local console = require("lib.console")
local ScreenManager = require("lib.screen_manager")

console.defineCommand(
    "switch", "Switches to a level", function(...)
      local cmd = {}
      for i = 1, select("#", ...) do
        cmd[i] = tostring(select(i, ...))
      end
      if #cmd == 0 then
        console.i("Usage: switch <level>")
      else
        console.i("Switching to level " .. cmd[1])
        ScreenManager.switch(cmd[1])
      end
    end)
