

WINDOW_HEIGHT = 1024;
WINDOW_WIDTH = 1728;


function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true,
  })
end


function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.setColor(0, 1, 0)

  love.graphics.printf('Hello PONG', 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center');

  

end