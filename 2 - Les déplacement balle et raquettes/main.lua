
scene = "game"

local GAME = require('game')

function love.load()
  SCREENWIDTH = love.graphics.getWidth()
  SCREENHEIGHT = love.graphics.getHeight()
  
  GAME.load()
end

function love.update(dt)
  GAME.update(dt)
end

function love.draw()
  GAME.draw()
end

function love.keypressed(key)
  GAME.keypressed(key)
end