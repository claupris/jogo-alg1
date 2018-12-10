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

  increase = 1;
  decrease = 1;
  temp = {};
  --           1    2    3    4    5    6    7    8    9   10
  listTemp = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil};

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
      local index = increase%(#listTemp + 1);
      if index == 0 then
        increase = 1;
      end
      listTemp[increase] = temp;
      increase = increase + 1;
    end
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
      local index = increase%(#listTemp + 1);
      if index == 0 then
        increase = 1;
      end
      listTemp[increase] = temp;
      increase = increase + 1;
    end
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
      local index = increase%(#listTemp + 1);
      if index == 0 then
        increase = 1;
      end
      listTemp[increase] = temp;
      increase = increase + 1;
    end  
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
      local index = increase%(#listTemp + 1);
      if index == 0 then
        increase = 1;
      end
      listTemp[increase] = temp;
      increase = increase + 1;
    end
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

      local index = decrease%(#listTemp + 1);
      if index == 0 then
        decrease = 1;
      end
      
      local dir = listTemp[decrease];

      if dir ~= nil and prox[2][1] ~= dir[1] then
        
        if start then
          print(i,' c ', current[2][1], current[1][2], current[1][3]);
          print(i + 1,' p ', prox[2][1], prox[2][2], prox[2][3]);
          print('dir ', dir[1], dir[2]. dir[3]);
          print('counters (i, d, s) ', increase, decrease, #listTemp);
          print('------------------------------------------');   
        end
        
        if prox[2][2] == dir[2] and prox[2][3] == dir[3] then 
          if #listTemp >= 1 then            
            current[2]  = dir; 
            
            decrease = decrease + 1;            
            print('array ', current[2][1], current[2][2], current[2][3]);
          else
            current[2]  = prox[2];
            print('cte ', current[2][1], current[2][2], current[2][3]);
          end
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

  end  

  if not food then
    semente_x, semente_y = positionFood();
  else
    love.graphics.draw(semente, semente_x, semente_y);
  end

end

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

  increase = 1;
  decrease = 1;
  temp = {};
  listTemp = {};

  local px, py = x, y; 

  for i = 1, 3 do
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

  return semente_x, semente_y;

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

-- funcão para aguardar um tempo
local clock = os.clock;
function sleep(n)  -- seconds
  local t0 = clock();
  local t1 = clock() - t0;
  while math.abs(t1) <= n do
    t1 = clock() - t0;
  end
end