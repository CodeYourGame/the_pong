
local game = {}
game.start = true

racket = {}
racket.width = 20
racket.height = 120
racket.speed = 205
racket[1] = {}
racket[1].x = 0
racket[1].y = 0
racket[1].score = 0
racket[2] = {}
racket[2].x = 0
racket[2].y = 0
racket[2].score = 0

ball = {}
ball.x = 0
ball.y = 0
ball.vx = 0
ball.vy = 0
ball.size = 20
ball.sticky = true

function reset()
  racket[1].x = 0
  racket[1].y = 0
  racket[2].x = SCREENWIDTH - racket.width
  racket[2].y = SCREENHEIGHT - racket.height
  resetBall()
end

function resetBall()
  ball.x = SCREENWIDTH/2
  ball.y = SCREENHEIGHT/2
  ball.sticky = true
end

function ball.start()
  ball.vx = -5
  ball.vy = -5
  ball.sticky = false
end

function game.load()
  reset()
end

function game.update(dt)
  
  if game.start == true and scene == 'game' then
    if love.keyboard.isDown('z') and racket[1].y > 0 then
      racket[1].y = racket[1].y - racket.speed*dt
    elseif love.keyboard.isDown('s') and racket[1].y+racket.height < SCREENHEIGHT then
      racket[1].y = racket[1].y + racket.speed*dt
    end
    
    if love.keyboard.isDown('up') and racket[2].y > 0 then
      racket[2].y = racket[2].y - racket.speed*dt
    elseif love.keyboard.isDown('down') and racket[2].y+racket.height < SCREENHEIGHT then
      racket[2].y = racket[2].y + racket.speed*dt
    end
  end
  
  if ball.x < racket[1].x + racket.width and ball.x >= racket[1].x and ball.y < racket[1].y + racket.height and ball.y >= racket[1].y then
    ball.x = racket[1].x + racket.width
    ball.vx = 0 - ball.vx
  end
  
  if ball.x < racket[2].x + racket.width and ball.x >= racket[2].x and ball.y < racket[2].y + racket.height and ball.y >= racket[2].y then
    ball.x = SCREENWIDTH - racket.width - ball.size
    ball.vx = 0 - ball.vx
  end

    
  if ball.y <= 0 or ball.y+ball.size > SCREENHEIGHT then
    if ball.y <= 0 then
      ball.y = 0
    elseif ball.y+ball.size > SCREENHEIGHT then
      ball.y = SCREENHEIGHT - ball.size
    end
    ball.vy = 0 - ball.vy
  end
  
  if ball.x < -10 or ball.x > SCREENWIDTH + 10 then
    if ball.x < -10 then
      racket[2].score = racket[2].score + 1
    else
      racket[1].score = racket[1].score + 1
    end
    resetBall()
  end
  
  if ball.sticky == false then
    ball.x = ball.x + ball.vx
    ball.y = ball.y + ball.vy
  end
  
end

function game.draw()
  -- ball
  love.graphics.rectangle('fill', ball.x - ball.size/2, ball.y - ball.size/2, ball.size, ball.size, 2)
  
  -- rackets
  love.graphics.rectangle('fill', racket[1].x, racket[1].y, racket.width, racket.height, 2)
  love.graphics.rectangle('fill', racket[2].x, racket[2].y, racket.width, racket.height, 2)
  
  -- line
  love.graphics.line(SCREENWIDTH/2, 0, SCREENWIDTH/2, SCREENHEIGHT)
  
  -- Score
  love.graphics.printf(racket[1].score, fonts.score, -(SCREENWIDTH/2) - 20, 20, SCREENWIDTH, 'right')
  love.graphics.printf(racket[2].score, fonts.score, (SCREENWIDTH/2) + 20, 20, SCREENWIDTH, 'left')
  
end

function game.keypressed(key)
  if scene == 'game' and key == 'space' then
    ball.start()
  end
end

return game