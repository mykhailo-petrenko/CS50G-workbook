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

ball = nil

gameState = nil

function scoreInitState()
  playerA_score = 0
  playerB_score = 0
end

Class = require 'hump.class'

require 'Ball'
require 'Paddle'

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


  ball = Ball(0, 0, BALL_SIZE, BALL_SIZE)
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
  end

  paddleA:update(dt)
  paddleB:update(dt)
end


function collider()
  if (ball.y < (ball.heigh /2) or ball.y > (WINDOW_HEIGHT - (ball.heigh /2))) then
    ball.dy = -1 * ball.dy
  elseif (ball.x < (ball.width /2) or ball.x > (WINDOW_WIDTH - (ball.width /2))) then
    ball.dx = -1 * ball.dx
  end
end