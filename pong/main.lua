

WINDOW_HEIGHT = 1024;
WINDOW_WIDTH = 1728;


playerA_score = 0;
playerB_score = 0;

paddleA_positionY = WINDOW_HEIGHT / 2;
paddleB_positionY = WINDOW_HEIGHT / 2;

PADDLE_SPEED = 333
PADDLE_HEIGHT = 200
PADDLE_WIDTH = 30

BALL_SPEED = 1
BALL_HEIGHT = 20
BALL_WIDTH = 20

ballPositionX = WINDOW_WIDTH / 2
ballPositionY = WINDOW_HEIGHT / 2

function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true,
  })

  math.randomseed(os.time())
end


function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.clear(0.1, 0.1, 0.1);

  love.graphics.setColor(1, 1, 1)
  love.graphics.printf('PONG', 0, 2, WINDOW_WIDTH, 'center');

  -- love.graphics.rectangle('line', 30, WINDOW_HEIGHT / 2 - 25, WINDOW_WIDTH-60, 50);

  -- Score
  love.graphics.printf(playerA_score, 0, 2, 100, 'right');
  love.graphics.printf(playerB_score, WINDOW_WIDTH-100, 2, 100, 'left');

  -- Paddles
  drawPaddle(PADDLE_WIDTH, paddleA_positionY)
  drawPaddle(WINDOW_WIDTH - PADDLE_WIDTH, paddleB_positionY)
  
  -- Ball
  drawBall(ballPositionX, ballPositionY)
end


function love.update(dt)
  if love.keyboard.isDown('w') then
    movePlayerA(-dt)
  elseif love.keyboard.isDown('s') then
    movePlayerA(dt)
  end


  if love.keyboard.isDown('up') then
    movePlayerB(-dt)
  elseif love.keyboard.isDown('down') then
    movePlayerB(dt)
  end

end

function constrainPlayerPosition(y)
  return math.min(
    WINDOW_HEIGHT - (PADDLE_HEIGHT / 2),
    math.max(
      (PADDLE_HEIGHT / 2),
      y
    )
  )
end

function movePlayerA(dt)
  paddleA_positionY = paddleA_positionY + PADDLE_SPEED * dt;
  paddleA_positionY = constrainPlayerPosition(paddleA_positionY)
end

function movePlayerB(dt)
  paddleB_positionY = paddleB_positionY + PADDLE_SPEED * dt;
  paddleB_positionY = constrainPlayerPosition(paddleB_positionY)
end

function drawPaddle(x, y)
  love.graphics.rectangle('fill', x - (PADDLE_WIDTH / 2), y - (PADDLE_HEIGHT / 2), PADDLE_WIDTH, PADDLE_HEIGHT);
end

function drawBall(x, y)
  love.graphics.rectangle('fill', x - (BALL_WIDTH / 2), y - (BALL_HEIGHT / 2), BALL_WIDTH, BALL_HEIGHT);
end