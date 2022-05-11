function love.conf(t)
  t.console = true
  if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    t.console = false
  end
  t.window.title = "Game Base"
end
