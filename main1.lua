altura = love.graphics.getWidth();
largura = love.graphics.getWidth();

px = 250;
py = 250;
ang = 0;
tam = 1/5;
origem = 0;

function love.load()
  imagem = love.graphics.newImage('imagens/circulo.png');
  fundo = love.graphics.newImage('imagens/cenario.png');
  fundo2 = love.graphics.newImage('imagens/cenario.png');
  --love.graphics.setBackground(fundo, fundo2);
  planoDeFundo = {
    x = 0,
    y = 0,
    y2 = 0 - fundo:getHeight(),
    vel = 30
    }
end

function love.update(dt)
  if love.keyboard.isDown("left") then
    px = px - 100*dt
    ang = ang - dt*1,5
  end
  if love.keyboard.isDown("right") then
    px = px + 100*dt
    ang = ang + dt*1,5
  end
  if love.keyboard.isDown("up") then
    py = py - 100*dt
    ang = ang - dt*1,5
  end
  if love.keyboard.isDown("down") then
    py = py + 100*dt
    ang = ang + dt*1,5
  end
  planoDeFundoscrolling(dt)
end


function love.draw()
  love.graphics.draw(imagem, px, py, rot, tam, tam, origem, origem)
  love.graphics.draw(fundo, planoDeFundo.x, planoDeFundo.y)
  love.graphics.draw(fundo2, planoDeFundo.x, planoDeFundo.y2)
end


function planoDeFundoScrolling(dt) 
planoDeFundo.y = planoDeFundo.y + planoDeFundo.vel * dt
planoDeFundo.y2 = planoDeFundo.y2 + planoDeFundo.vel * dt

  if planoDeFundo.y > altura then
    planoDeFundo.y = planoDeFundo.y2 - fundo2:getHeight()
  end
  if planoDeFundo.y2 > altura then
    planoDeFundoy2 = planoDeFundo.y - fundo:getHeight()
  end
end

