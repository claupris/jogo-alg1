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

  -- semente
  semente = love.graphics.newImage ("imagens/hamtaro/comida.png");

  -- width_snake = largura da cobrinha
  WIDTH_SNAKE = snake[1]:getWidth();

  WIDTH_FOOD = semente:getWidth();

  -- coordenada de posição x, y e velocidade da cobrinha
  x = 155;
  y = 155;
  speed = 150;
  food = false;
  start = false;
  snakeSize = 3;

  -- config snake iniciais    
  noSnake = {};  
  noDirecao = {};
  bodySnake = {};
  current = {};
  prox = {};

  -- config comida (food) iniciais
  intersect = false;
  noFood = {semente, nil, nil};

  -- config dos pontos
  score = 0;

  temp = {};

  startSnake();

end

-- atualiza
function love.update(dt)
  -- direção que o usuário dá para a cobrinha
  local tp = {};
  if (love.keyboard.isDown ("d") or love.keyboard.isDown ("right")) and current[2][1] ~= 'F'  and current[2][1] ~= 'B' then
    --x = x + (speed * dt);      
    if #temp == 0 then
      tp[1] = bodySnake[snakeSize][1][snakeSize];
      tp[2] = bodySnake[snakeSize][2][snakeSize];

      temp = {
        'F',
        tp[1][2],
        tp[1][3]
      }  
      bodySnake[snakeSize][2][snakeSize] = temp;
    end
    print(dt);
  end

  if (love.keyboard.isDown ("a") or love.keyboard.isDown ("left")) and current[2][1] ~= 'F'  and current[2][1] ~= 'B' then
    --x = x - (speed * dt);   
    if #temp == 0 then
      tp[1] = bodySnake[snakeSize][1][snakeSize];
      tp[2] = bodySnake[snakeSize][2][snakeSize];
      temp = {
        'B',
        tp[1][2],
        tp[1][3]
      }  
      bodySnake[snakeSize][2][snakeSize] = temp;
    end
    print(dt);
  end

  if (love.keyboard.isDown ("w") or love.keyboard.isDown ("up")) and current[2][1] ~= 'U'  and current[2][1] ~= 'D' then
    --y = y - (speed * dt);
    if #temp == 0 then
      tp[1] = bodySnake[snakeSize][1][snakeSize];
      tp[2] = bodySnake[snakeSize][2][snakeSize];
      temp = {
        'U',
        tp[1][2],
        tp[1][3]
      }  
      bodySnake[snakeSize][2][snakeSize] = temp;
    end  
    print(dt); 
  end

  if (love.keyboard.isDown ("s") or love.keyboard.isDown ("down")) and current[2][1] ~= 'U'  and current[2][1] ~= 'D'   then
    --y = y + (speed * dt);   
    if #temp == 0 then
      tp[1] = bodySnake[snakeSize][1][snakeSize];
      tp[2] = bodySnake[snakeSize][2][snakeSize];
      temp = {
        'D',
        tp[1][2],
        tp[1][3]
      }  
      bodySnake[snakeSize][2][snakeSize] = temp; 
    end
    print(dt);
  end

  if love.keyboard.isDown ("return") then
    if not food then
      food = true;
      start = true;
    end    
  end

  if love.keyboard.isDown ("space")  then
    startSnake();
  end

  if love.keyboard.isDown ("escape")  then
    love.window.close();
    os.exit(0);
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
  local i = 1;  
  while i <= snakeSize do  

    current[1] = bodySnake[i][1][i];
    current[2] = bodySnake[i][2][i];      

--[[ ]]--
    if i < snakeSize then   
      prox[1] = bodySnake[i + 1][1][i + 1];
      prox[2] = bodySnake[i + 1][2][i + 1];       
      if prox[2][1] ~= current[2][1] then
        if start then
          print(i,' c ', current[2][1], current[1][2], current[1][3]);
          print(i + 1,' p ', prox[2][1], prox[2][2], prox[2][3]);
          print('------------------------------------------');   
        end
        if prox[2][2] == current[1][2] and prox[2][3] == current[1][3] then 
          current[2]  = prox[2];
        end
      end
    end
--[[ ]]--

    if not start then
      love.graphics.draw(current[1][1], current[1][2], current[1][3]); 
    else
      current = walkSnake();        

      love.graphics.draw(current[1][1], current[1][2], current[1][3]); 
    end

    bodySnake[i][1][i] = current[1];
    bodySnake[i][2][i] = current[2];

    i = i + 1;

    temp = {};

  end

  if not food then
    love.graphics.print({{0, 0, 0, 1},'POINTS: ' .. score}, WIDTH_CENARIO/2 + 110, 100, 0, 2, 2);
    love.graphics.print({{0, 0, 0, 1},'PUSH ENTER TO START'}, WIDTH_CENARIO/2, HEIGHT_CENARIO/2 + 120, 0, 2, 2);
    noFood = positionFood();
  else
    intersect = colision();
    if intersect then
      score = score + 50;      
      noFood = positionFood();
      --addNoSnake();
    end    
    love.graphics.draw(noFood[1], noFood[2], noFood[3]);
    love.graphics.print({{0, 0, 0, 1},'PONTOS: ' .. score}, WIDTH_CENARIO/2 + 110, 100, 0, 2, 2);
  end

  if not start and score > 0 then
    love.graphics.print({{0, 0, 0, 1},'GAME OVER'}, WIDTH_CENARIO/2 + 90, HEIGHT_CENARIO/2 + 120, 0, 2, 2);
  end

end

-- reinicia uma nova partida 
function startSnake()   

  x = 155;
  y = 155;
  speed = 150;
  food = false;
  start = false;
  snakeSize = 3;    

  noSnake = {};  
  noDirecao = {};
  bodySnake = {};
  current = {};
  prox = {};

  -- config comida (food) iniciais
  intersect = false;
  noFood = {semente, nil, nil};

  -- config dos pontos
  score = 0;

  temp = {};

  local px, py = x, y; 

  for i = 1, snakeSize do
    local idx = math.random(#snake);

    noSnake[i] = {};    
    noSnake[i][1] = snake[idx]
    noSnake[i][2] = px;
    noSnake[i][3] = py;

    bodySnake[i] = {};
    bodySnake[i][1] = noSnake;

    noDirecao[i] = {};
    noDirecao[i][1] = 'F';
    noDirecao[i][2] = px;
    noDirecao[i][3] = py;

    bodySnake[i][2] = noDirecao;

    px = px + WIDTH_SNAKE;
  end

end


-- gera as posicoes da comida randomicamente
function positionFood() 
  -- locais da semente
  semente_x = math.random(155, 150 + WIDTH_CENARIO);
  semente_y = math.random(155, 150 + HEIGHT_CENARIO);

  -- condiçoes para que a semente fique dentro do cenário
  if semente_x < 155 then
    semente_x = 155;
  elseif semente_x >= (125 + WIDTH_CENARIO) then
    semente_x = WIDTH_CENARIO - 155;
  end

  if semente_y < 155 then
    semente_y = 155;
  elseif semente_y >= (100 + HEIGHT_CENARIO) then
    semente_y = HEIGHT_CENARIO - 105;
  end   

  noFood[2] = semente_x;
  noFood[3] = semente_y;

  return noFood;

end


-- função que faz a cobrinha andar independentemente
function walkSnake()
  if current[2][1] == 'F' then
    if current[1][2] < (110 + WIDTH_CENARIO) then
      current[1][2] = current[1][2] + 1;
    else
      start = false;

    end
  end
  if current[2][1] == 'B' then
    if current[1][2] >= 150 then
      current[1][2] = current[1][2] - 1;
    else
      start = false;

    end
  end
  if current[2][1] == 'U' then
    if current[1][3] >= 150  then
      current[1][3] = current[1][3] - 1;
    else
      start = false;

    end
  end
  if current[2][1] == 'D' then
    if current[1][3] < (110 + HEIGHT_CENARIO)then
      current[1][3] = current[1][3] + 1;
    else
      start = false;

    end
  end
  return {current[1], current[2]};   
end

-- adicona no no na cobrinha
function addNoSnake()
  local head = {};
  head[1] = bodySnake[snakeSize][1][snakeSize];
  head[2] = bodySnake[snakeSize][2][snakeSize];
  local idx = math.random(#snake);
  
  print('size ', snakeSize);

  snakeSize = snakeSize + 1;

  bodySnake[snakeSize] = {};

  noSnake[snakeSize] = {};    
  noSnake[snakeSize][1] = snake[idx];
  if head[2][1] == 'F' or head[2][1] == 'B' then
    noSnake[snakeSize][2] = head[1][2] + WIDTH_SNAKE;
    noSnake[snakeSize][3] = head[1][3];
  else
    noSnake[snakeSize][2] = head[1][2];
    noSnake[snakeSize][3] = head[1][3] + WIDTH_SNAKE;
  end

  bodySnake[snakeSize][1] = noSnake;

  noDirecao[snakeSize] = {};
  noDirecao[snakeSize][1] = head[2][1];
  if head[2][1] == 'F' or head[2][1] == 'B' then
    noDirecao[snakeSize][2] = head[2][2] + WIDTH_SNAKE;
    noDirecao[snakeSize][3] = head[2][3] ;
  else
    noDirecao[snakeSize][2] = head[2][2];
    noDirecao[snakeSize][3] = head[2][3] + WIDTH_SNAKE;
  end
  
  bodySnake[snakeSize][2] = noDirecao;
end

-- verifica se a colisão entre entidades(entre comida e a frente da snake)
function colision()
  local head = bodySnake[snakeSize][1][snakeSize];
  local consum = noFood;
  return (head[2] <= (consum[2] + WIDTH_FOOD)  and head[3] <= (consum[3] + WIDTH_FOOD) 
    and consum[2] <= (head[2] + WIDTH_SNAKE - 10) and consum[3] <= (head[3] + WIDTH_SNAKE - 10));
end

-- funcão para aguardar um tempo
local clock = os.clock;
function sleep(n)  -- seconds
  local t0 = clock();
  local t1 = clock() - t0;
  while math.abs(t1) <= n do
    t1 = clock() - t0;
  end
end