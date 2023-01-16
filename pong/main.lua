Class = require 'hump.class'

require 'Ball'
require 'Paddle'

WINDOW_HEIGHT = 1024;
WINDOW_WIDTH = 1728;

playerA_score = nil
playerB_score = nil

paddleA = nil
paddleB = nil

PADDLE_SPEED = 0
PADDLE_HEIGHT = 200
PADDLE_WIDTH = 30

BALL_SPEED = 0
BALL_SIZE = 20

ball = Ball(0, 0, BALL_SIZE, BALL_SIZE)

gameState = nil

function scoreInitState()
  playerA_score = 0
  playerB_score = 0
end


function gameInitState()
  gameState = 'start'

  paddleA_positionY = WINDOW_HEIGHT / 2;
  paddleB_positionY = WINDOW_HEIGHT / 2;

  PADDLE_SPEED = 420
  PADDLE_HEIGHT = 200
  PADDLE_WIDTH = 30

  BALL_SPEED = 0.5
  BALL_HEIGHT = 20
  BALL_WIDTH = 20

  ball:reset()

  paddleA = Paddle(PADDLE_WIDTH/2, WINDOW_HEIGHT/2, PADDLE_WIDTH, PADDLE_HEIGHT, 'w', 's')
  paddleB = Paddle(WINDOW_WIDTH - PADDLE_WIDTH/2, WINDOW_HEIGHT/2, PADDLE_WIDTH, PADDLE_HEIGHT, 'up', 'down')
end

function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true,
  })

  math.randomseed(os.time())
  
  scoreInitState()
  gameInitState()
end


function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  if key == 'space' then
    if (gameState == 'play') then
      gameState = 'pause'
    else
      gameState = 'play'
    end
  end

end

function love.draw()
  love.graphics.clear(0.1, 0.1, 0.1);

  love.graphics.setColor(1, 1, 1)
  love.graphics.printf('PONG', 0, 2, WINDOW_WIDTH, 'center');

  -- Score
  love.graphics.printf(playerA_score, 0, 2, 100, 'right');
  love.graphics.printf(playerB_score, WINDOW_WIDTH-100, 2, 100, 'left');
  
  -- Ball
  ball:render()

  -- Paddles
  paddleA:render()
  paddleB:render()
end


function love.update(dt)
  if (gameState == 'play') then
    ball:update(dx)
    collider()

    paddleA:update(dt)
    paddleB:update(dt)
  end
end


function collider()
  center = WINDOW_WIDTH / 2

  if (ball.y < (ball.height /2) or ball.y > (WINDOW_HEIGHT - (ball.height /2))) then
    ball.dy = -1 * ball.dy
  end
  
  if (ball.x < center) then
    if collideWithPaddle(ball, paddleA) then
      -- reflect from paddle A
      ball.dx = ball.dx * -1
    end
  else
    if collideWithPaddle(ball, paddleB) then
      -- reflect from paddle B
      ball.dx = ball.dx * -1
    end
  end
  
  if (ball.x < (ball.width * 0.75) or ball.x > (WINDOW_WIDTH - (ball.width * 0.75))) then
    ball.dx = -1 * ball.dx
    gameState = 'stop'
  end
end

function collideWithPaddle(ball, paddle) 
  
  dx = math.abs(ball.x - paddle.x)
  dy = math.abs(ball.y - paddle.y)
  maxDx = (paddle.width / 2) + (ball.width / 2)
  maxDy = (paddle.height / 2) + (ball.height / 2)

  if ((dx <= maxDx) and (dy <= maxDy)) then
    return true
  end

  return false
end