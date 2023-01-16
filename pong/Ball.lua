
Ball = Class{}

function Ball:init(x, y, wigth, height) 
  self.x = x
  self.y = y
  self.width = wigth
  self.height = height

  self.dx = 0
  self.fy = 0
end

function Ball:reset()
  self.x = WINDOW_WIDTH / 2;
  self.y = WINDOW_HEIGHT / 2;

  self.dx = (math.random(2) == 1) and 10 or -10
  self.dy = math.random(-10, 10)
end

function Ball:update(dt)
  self.x = self.x + BALL_SPEED * self.dx
  self.y = self.y + BALL_SPEED * self.dy
end

function Ball:render()
  love.graphics.rectangle('fill', self.x - (self.width / 2), self.y - (self.height / 2), self.width, self.height);
end