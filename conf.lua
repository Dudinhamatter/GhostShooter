function love.conf(t)
  t.title = "Ghost Shooter"
  t.version = "11.4"
  t.console = true
  t.window.width = 480
  t.window.height = 432
  t.window.fullscreen = false
  --t.window.usedpiscale = true
  --t.window.vsync = 1
  --t.externalstorage=true
  t.accelerometerjoystick = false

  io.stdout:setvbuf('no')
end