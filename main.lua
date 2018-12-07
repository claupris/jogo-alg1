math.randomseed(os.time())
-- carrega
function love.load () 

  -- define tamanho da janela, se pode ser redimensinada
  love.window.setMode(980, 640, {resizable=true, vsync=false, minwidth=980, minheight=640});  
  WIDTH = love.graphics.getWidth();
  HEIGHT = love.graphics.getHeight();
  
  -- background
  background = love.graphics.newImage('imagens/hamtaro/background.jpg');
  
  -- largura e altura do cenário
  WIDTH_CENARIO = WIDTH - 300;
  HEIGHT_CENARIO = HEIGHT - 200;
    
  -- retângulo onde a cobra pode se movimentar
  cenarioSnake = love.graphics.newImage("imagens/cenario.png");

  --  cobrinha
  snake = {};
  snake[1] = love.graphics.newImage ("imagens/hamtaro/hamster1.png");
  snake[2] = love.graphics.newImage ("imagens/hamtaro/hamster2.png");
  snake[3] = love.graphics.newImage ("imagens/hamtaro/hamster3.png"); 
  
  --
  WIDTH_SNAKE = snake[1]:getWidth();

  -- coordenada de posição x, y e velocidade
  x = 155;
  y = 155;
  speed = 150;
  start = false;
  snakeSize = 3;
  
   -- snake sorteados    
  snakeSorteados = {};
  for i = 1, 3 do
    local idx = math.random(#snake);
     snakeSorteados[i] = snake[idx];
  end

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
  -- obtendo largura e altura da janela
  WIDTH = love.graphics.getWidth();
  HEIGHT = love.graphics.getHeight();

  -- definindo a escala do background(janela)
  local scaleX = WIDTH / background:getWidth();
  local scaleY = HEIGHT / background:getHeight();
  
  -- desenha o background
  love.graphics.draw(background, 0, 0, 0, scaleX, scaleY);
  
  -- largura e altura do cenário
  WIDTH_CENARIO = WIDTH - 300;
  HEIGHT_CENARIO = HEIGHT - 200;
  
  -- definindo a escala do cenário
  local scaleCenarioX = WIDTH_CENARIO / cenarioSnake:getWidth();
  local scaleCenarioY = HEIGHT_CENARIO / cenarioSnake:getHeight();
  
  -- desenha cenário
  love.graphics.draw(cenarioSnake, 150, 150, 0, scaleCenarioX, scaleCenarioY);
  
  WIDTH_SNAKE = snake[1]:getWidth();
  
  -- circulo da cobrinha  
  print(snakeSize);
  local j = x;
  local i = 1;
  while i <= snakeSize do
    love.graphics.draw(snakeSorteados[i], j, y);   
    j = j + WIDTH_SNAKE;
    i = i + 1;
  end  
  
 
end
