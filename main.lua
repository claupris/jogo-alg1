-- carrega
function love.load () 

  -- define tamanho da janela, se pode ser redimensinada
  love.window.setMode(980, 640, {resizable=true, vsync=false, minwidth=980, minheight=640});  
  WIDTH = love.graphics.getWidth();
  HEIGHT = love.graphics.getHeight();

  -- background
  background = love.graphics.newImage('imagens/hamtaro/background.jpg');

  -- circulo
  circulo = love.graphics.newImage ("imagens/hamtaro/hamster2.png");

  -- coordenada de posição x, e velocidade
  x = 100;
  y = 50;
  speed = 300;

end

-- atualiza
function love.update(dt) 

  if love.keyboard.isDown ("d") then
    x = x + (speed * dt);
  elseif love.keyboard.isDown ("right") then
    x = x + (speed * dt);
  end

  if love.keyboard.isDown ("a") then
    x = x - (speed * dt);
  elseif love.keyboard.isDown ("left") then
    x = x - (speed * dt);
  end

  if love.keyboard.isDown ("w") then
    y = y - (speed * dt);
  elseif love.keyboard.isDown ("up") then
    y = y - (speed * dt);
  end

  if love.keyboard.isDown ("s") then
    y = y + (speed * dt);
  elseif love.keyboard.isDown ("down") then
    y = y + (speed * dt);
  end

end

-- desenha
function love.draw() 
  --  obtendo largura e altura
  WIDTH = love.graphics.getWidth();
  HEIGHT = love.graphics.getHeight();

  -- background
  local scaleX = WIDTH / background:getWidth();
  local scaleY = HEIGHT / background:getHeight();
  love.graphics.draw(background, 0, 0, 0, scaleX, scaleY);

  -- circulo
  love.graphics.draw(circulo, x, y);
end

--[[


function love.load()
    
  fundo = love.graphics.newImage("imagens/universo.jpg");
  
  player1 = {
    x = 390,
    y = 300,
    width = 50,
    height = 50,
    collided = false
  }
  box1 = {
    x = 100,
    y = 300,
    width = 50,
    height = 50
  }
  box2 = {
    x = 650,
    y = 275,
    width = 100,
    height = 100
  }
end


function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function love.update(dt)
  if love.keyboard.isDown("left") then
    player1.x = player1.x - (300 * dt)
  end
  if love.keyboard.isDown("right") then
    player1.x = player1.x + (300 * dt)
  end
  if love.keyboard.isDown("up") then
    player1.y = player1.y - (300 * dt)
  end
  if love.keyboard.isDown("down") then
    player1.y = player1.y + (300 * dt)
  end
  if CheckBoxCollision(player1.x, player1.y, player1.width,
    player1.height, box1.x, box1.y, box1.width, box1.height) or
    CheckBoxCollision(player1.x, player1.y, player1.width,
    player1.height, box2.x, box2.y, box2.width, box2.height) then
    player1.collided = true
  else
    player1.collided = false
  end
end


function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill", box1.x, box1.y,
  box1.width, box1.height)
  love.graphics.rectangle("fill", box2.x, box2.y,
  box2.width, box2.height)
  if player1.collided == true then
    love.graphics.setColor(255,0,0)
  end
  love.graphics.rectangle("fill", player1.x, player1.y,
  player1.width, player1.height)
end

]]--

