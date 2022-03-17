io.stdout:setvbuf('no')
blanc = love.graphics.newImage("blanc.jpg")
bw = blanc:getWidth()
bh = blanc:getHeight()
love.window.setMode(800,600)
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()
j1  = {}
j1.x = 50
j1.y = 50 
j1.o = 0
j1.speed = 7
j1.liste = {}
j1.hitB = {}
function j1.dessin(x,y,r,liste)
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(blanc,x,y,r,30/bw,15/bh,bw/2,bh/2)
  for i = 1,#liste do 
    love.graphics.setColor(0,0,1,1)
    --love.graphics.rectangle("fill",liste[i][1],liste[i][2],2,2)
    love.graphics.draw(blanc,liste[i][1],liste[i][2],0,7/bw,7/bh,bw/2,bh/2)
  end 
end
d = true


j2  = {}
j2.x = largeur-50
j2.y = hauteur-50 
j2.o = math.pi
j2.speed = 7
j2.liste = {}
j2.hitB = {}
function j2.dessin(x,y,r,liste)
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(blanc,x,y,r,30/bw,15/bh,bw/2,bh/2)
  for i = 1,#liste do 
    love.graphics.setColor(1,0,0,1)
    --love.graphics.rectangle("fill",liste[i][1],liste[i][2],2,2)
    love.graphics.draw(blanc,liste[i][1],liste[i][2],0,7/bw,7/bh,bw/2,bh/2)
  end 
end

function love.draw()
  j1.dessin(j1.x,j1.y,j1.o,j1.liste)
  j2.dessin(j2.x,j2.y,j2.o,j2.liste)
  
  for i = 1,#j1.hitB do
    love.graphics.setColor(1,0,0,1)
    love.graphics.circle("fill",j1.hitB[i][1],j1.hitB[i][2],1)
  end
  for i = 1,#j2.hitB do
    love.graphics.setColor(1,0,0,1)
    love.graphics.circle("fill",j2.hitB[i][1],j2.hitB[i][2],1)
  end
  
  for i = 1,#j1.liste do
    for j = 1,#j1.hitB do
      if j1.hitB[j][1] < j1.liste[i][1]+3.5 and j1.hitB[j][1] > j1.liste[i][1]-3.5 and j1.hitB[j][2] < j1.liste[i][2]+3.5 and j1.hitB[j][2] > j1.liste[i][2]-3.5 then
        love.graphics.print("GAME OVER",10,10)
        d = false
      elseif j1.hitB[j][1] < j2.liste[i][1]+3.5 and j1.hitB[j][1] > j2.liste[i][1]-3.5 and j1.hitB[j][2] < j2.liste[i][2]+3.5 and j1.hitB[j][2] > j2.liste[i][2]-3.5 then
        love.graphics.print("GAME OVER",10,10)
        d = false
      end
    end
    
    for i = 1,#j2.liste do
    for j = 1,#j2.hitB do
      if j2.hitB[j][1] < j2.liste[i][1]+3.5 and j2.hitB[j][1] > j2.liste[i][1]-3.5 and j2.hitB[j][2] < j2.liste[i][2]+3.5 and j2.hitB[j][2] > j2.liste[i][2]-3.5 then
        love.graphics.print("GAME OVER",10,10)
        d = false
      elseif j2.hitB[j][1] < j1.liste[i][1]+3.5 and j2.hitB[j][1] > j1.liste[i][1]-3.5 and j2.hitB[j][2] < j1.liste[i][2]+3.5 and j2.hitB[j][2] > j1.liste[i][2]-3.5 then
        love.graphics.print("GAME OVER",10,10)
        d = false
      end
    end
  end
  end
end

function love.update(dt)
  if d then
    deplacement(j1)
    deplacement(j2)
    key()
  end
  j1.hitB = hitboxRect(j1.x,j1.y,30,15,j1.o)
  j2.hitB = hitboxRect(j2.x,j2.y,30,15,j2.o)
  
end


function deplacement(j)
  j.liste[#j.liste+1] = {j.x - math.cos(j.o)*20,j.y - math.sin(j.o)*20} 
  j.x = j.x + math.cos(j.o) * j.speed
  j.y = j.y + math.sin(j.o) * j.speed
end



function key()
  if love.keyboard.isDown('q') then
    j1.o = j1.o - 0.1--*j.speed/10
  end
  if love.keyboard.isDown('d') then
    j1.o = j1.o + 0.1--*j.speed/10
  end
  
  if love.keyboard.isDown('m') then
    j2.o = j2.o + 0.1--*j.speed/10
  end
  if love.keyboard.isDown('k') then
    j2.o = j2.o - 0.1--*j.speed/10
  end
  
end



function hitboxRect(x,y,l,h,rot) -- fonction qui ne marche que si X et Y sont au milieux de la figure
  local pts = {}
  local x1 =  x + math.cos(rot) * l/2
  local y1 =  y + math.sin(rot) * l/2
  pts[#pts+1] = {x1,y1}
  
  local x2 =  x + math.cos(math.pi + rot) * l/2
  local y2 =  y + math.sin(math.pi + rot) * l/2
  pts[#pts+1] = {x2,y2}
  
  local x3 =  x + math.cos(-math.pi/2 + rot) * h/2
  local y3 =  y + math.sin(-math.pi/2 + rot) * h/2
  pts[#pts+1] = {x3,y3}
  
  local x4 =  x + math.cos(math.pi/2 + rot) * h/2
  local y4 =  y + math.sin(math.pi/2 + rot) * h/2
  pts[#pts+1] = {x4,y4}
  
  
  local r = ((l/2)^2+(h/2)^2)^0.5
  
  local x5 = x + math.cos(math.atan((y3-y)/(x1-x))+rot) * r 
  local y5 = y + math.sin(math.atan((y3-y)/(x1-x))+rot) * r 
  pts[#pts+1] = {x5,y5}
  
  local x6 = x + math.cos(math.atan((y4-y)/(x1-x))+rot) * r 
  local y6 = y + math.sin(math.atan((y4-y)/(x1-x))+rot) * r 
  pts[#pts+1] = {x6,y6}
  
  
  local x7 = x + math.cos(math.atan((y3-y)/(x2-x))+rot+math.pi) * r
  local y7 = y + math.sin(math.atan((y3-y)/(x2-x))+rot+math.pi) * r
  pts[#pts+1] = {x7,y7}
  
  local x8 = x + math.cos(math.atan((y4-y)/(x2-x))+rot+math.pi) * r
  local y8 = y + math.sin(math.atan((y4-y)/(x2-x))+rot+math.pi) * r
  pts[#pts+1] = {x8,y8}
  
  return pts
end

