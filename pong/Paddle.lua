Paddle = Class{}

function Paddle:init(x, y, width, height, UP, DOWN)
  self.x = x
  self.y = y
  self.INITIAL_Y = y

  self.width = width
  self.height = height

  self.UP = UP
  self.DOWN = DOWN

  self.direction = 0 -- move direction (1 down, -1 up)
end

function Paddle:reset()
  self.y = self.INITIAL_Y
end

function Paddle:update(dt)
  if love.keyboard.isDown(self.UP) then
    self:move(dt, PADDLE_SPEED * -1)
    self.direction = -1
  elseif love.keyboard.isDown(self.DOWN) then
    self:move(dt, PADDLE_SPEED)
    self.direction = 1
  else
    self.direction = 0
  end
end

function Paddle:render()
  x = self.x - self.width / 2
  y = self.y - self.height / 2
  love.graphics.rectangle('fill', x, y, self.width, self.height);
end

function Paddle:move(dt, speed)
  self.y = self.y + speed * dt;
  self:constrainPosition()
end

function Paddle:constrainPosition()
  self.y = math.min(
    WINDOW_HEIGHT - self.height / 2,
    math.max((self.height / 2), self.y)
  )
end