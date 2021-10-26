pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
--game name goes here
--by gouspourd,yolwoocle,notgoyome

function _init()
	init_player()
	init_bullet()
end

function _update60()
 mouse_x_y()
	update_bullet()
	player_update()	
	for i in all(players) do
	 if (stat(34) & 1 == 1) spawn_bullet(i.x,i.y,2,2,10,1,3)
	 if (stat(34) & 2 == 2) spawn_bullet(i.x,i.y,2,4,5,6,10)
	end
end

function _draw()
 cls()
 map()
	draw_bullet()
	draw_mouse()
	draw_player()
	check_flag(1,mouse_x,mouse_y)
	
	print(players[1].dx, 0,0)
	print(players[1].dy, 0,10)
	print (timeur_bullet,15,15)

end
-->8
--player
function init_player()
	players={}
	add(players, 
	{
		n=1,
		
		x=64,y=64,
		dx=0,dy=0,
		
		spd=.5,
		fric=0.8,
		
		bx=0,by=0,
		bw=8,bh=8,
	})
end

function player_update()
	for p in all(players) do
	 local dx,dy = p.dx,p.dy
	 local spd = p.spd
	 
	 if (btn(⬅️,p.n)) p.dx-=spd
	 if (btn(➡️,p.n)) p.dx+=spd
	 if (btn(⬆️,p.n)) p.dy-=spd
	 if (btn(⬇️,p.n)) p.dy+=spd
	 p.dx *= p.fric
	 p.dy *= p.fric
	 
	 collide(p)
	 
	 p.x += p.dx
	 p.y += p.dy
	end
end

function draw_player()
	for p in all(players) do
		spr(3,p.x,p.y)
		spr(16,p.x+5,p.y-7)
	end
end

-->8
--gun & bullet
function init_bullet()
	bullet = {}
	timeur_bullet = 0
end

function spawn_bullet(x,y,type_bullet,speed,timeur_bullet1,sprite,nb_bullet)
 if timeur_bullet == 0 then
 local xy = get_traj(x,y,mouse_x,mouse_y)
 local traj_x = xy.x*speed
 local traj_y = xy.y*speed
 local angle = xy.angle
	timeur_bullet = timeur_bullet1
	
	if type_bullet == 1 then
	 add(bullet,{x=x,y=y,type_bullet=type_bullet,traj_x=traj_x,traj_y=traj_y,sprite=sprite})
 end
 
 if type_bullet == 2 then
  for i=1,nb_bullet do
  	add(bullet,
  	{x=x,y=y
  	,type_bullet=type_bullet
  	,traj_x=cos(angle+i/10)*speed
  	,traj_y=sin(angle+i/10)*speed
  	,sprite=sprite})
   
  end
 end
 end
end
-- -(i/2)+i/nb_bullet
function update_bullet()
 if (timeur_bullet>0)timeur_bullet-=1
	for i in all(bullet) do
		if is_solid(i.x+(i.traj_x*1.5)+4,i.y+4+(i.traj_y*1.5)) then
		 del(bullet,i)
	 end
		i.x += i.traj_x
		i.y += i.traj_y
	end
end

function draw_bullet()
	for i in all(bullet) do
		spr(i.type_bullet,i.x,i.y)
	end
end

-->8
--mouse
function mouse_x_y()
	poke(0x5f2d, 1)
	mouse_x=stat(32)
	mouse_y=stat(33)
end

function get_traj(x_satr,y_start,x_end,y_end)
	angle=atan2(x_end-x_satr-4, y_end-y_start-4)
	return {x = cos(angle),y = sin(angle),angle=angle}
end

function draw_mouse()
	spr(2,mouse_x,mouse_y)
end

function check_flag(flag,x,y)
	return fget(mget((x\8),(y\8)),flag)
end

-->8
--collision
function is_solid(x,y)
	return check_flag(0,x,y)
end

function collision(x,y,h,w,flag)
	return 
	   is_solid(x,  y)
	or is_solid(x+7,y)
	or is_solid(x,  y+7)
	or is_solid(x+7,y+7) 
end

function collide(o)
	local x,y = o.x,o.y
	local dx,dy = o.dx,o.dy
	local w,h = o.bw,o.bh
	local ox,oy = x+o.bx,y+o.by
	local bounce = 0.1
	
	--collisions
	local coll_x = collision( 
	ox+dx, oy,    w, h)
	local coll_y = collision(
	ox,    oy+dy, w, h)
	local coll_xy = collision(
	ox+dx, oy+dy, w, h)
	
	if coll_x then
		o.dx *= -bounce
	end
	
	if coll_y then
		o.dy *= -bounce
	end
	
	if coll_xy and 
	not coll_x and not coll_y then
		--prevent stuck in corners 
		o.dx *= -bounce
		o.dy *= -bounce
	end
end
__gfx__
00000000000000007000000000005d0081661168550000550000000000003b00000000000088880000005d00011100000000eee0000000000000000000000000
0000000000000000770000000005ddd0165116555000000500000000000333b000000000087178700005ddd01779aa100000e775000000000000000000222200
00700700000990007770000000052dd015111155000000000008800000031aa0000000000877717700052dd01c799991e0000e05000000000000000002888820
00077000009aa900711000005003dd771116611100000000008ee80001133a9900000000088711665003dd77177888890eeeee00000000000000000028e88882
00077000009aa90011000000566233306116551100000000008ee800dddd334000000000aa882800566233301177100800eee000000000000000000028818182
007007000009900000000000d566222056115116000000000008800016664440000044001baa2800d56622201111100000707000000000000000000028212182
0000000000000000000000000d6666005561116550000005000000000164440000414690011180000d6666000111000000707000000000000000000028222282
00000000000000000000000000080800855166585500005500000000009090000004600000505000000808000c0c000000707000000000000000000002222220
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0466ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44455000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000071177777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077711777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777117
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d777777d
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007dddddd7
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ddd22ddd
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddd0
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000806600688066006880660068806600688066006880660068806600680000000000000000
00000000000000000000000000000000000000000000000000000000065006550650065506500655065006550650065506500655065006550000000000000000
00000000000000000000000000000000000000000000000000000000050000550500005505000055050000550500005505000055050000550000000000000000
00000000000000000000000000000000000000000000000000000000000660000006600000066000000660000006600000066000000660000000000000000000
00000000000000000000000000000000000000000000000000000000600655006006550060065500600655006006550060065500600655000000000000000000
00000000000000000000000000000000000000000000000000000000560050065600500656005006560050065600500656005006560050060000000000000000
00000000000000000000000000000000000000000000000000000000556000655560006555600065556000655560006555600065556000650000000000000000
00000000000000000000000000000000000000000000000000000000855066588550665885506658855066588550665885506658855066580000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000806600680000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065006550000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000550000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000660000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600655000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000560050060000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000556000650000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000855066580000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000806600680000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065006550000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000550000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000660000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600655000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000560050060000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000556000650000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000855066580000000000000000
00000000806600688066006800000000000000000000000000000000000000000000000000000000000000000000000000000000806600680000000000000000
00000000065006550650065500000000000000000000000000000000000000000000000000000000000000000000000000000000065006550000000000000000
00000000050000550500005500000000000000000000000000000000000000000000000000000000000000000000000000000000050000550000000000000000
00000000000660000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000660000000000000000000
00000000600655006006550000000000000000000000000000000000000000000000000000000000000000000000000000000000600655000000000000000000
00000000560050065600500600000000000000000000000000000000000000000000000000000000000000000000000000000000560050060000000000000000
00000000556000655560006500000000000000000000000000000000000000000000000000000000000000000000000000000000556000650000000000000000
00000000855066588550665800000000000000000000000000000000000000000000000000000000000000000000000000000000855066580000000000000000
00000000806600680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000806600680000000000000000
00000000065006550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065006550000000000000000
00000000050000550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000550000000000000000
00000000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000660000000000000000000
00000000600655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600655000000000000000000
00000000560050060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000560050060000000000000000
00000000556000650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000556000650000000000000000
00000000855066580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000855066580000000000000000
00000000806600680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000806600680000000000000000
00000000065006550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065006550000000000000000
00000000050000550000000000000000000000000000000000000000000000000077700000000000000000000000000000000000050000550000000000000000
00000000000660000000000000000000000000000000000000000000000000000071100000000000000000000000000000000000000660000000000000000000
00000000600655000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000600655000000000000000000
00000000560050060000000000000000000000000000000000000000000000000010000000000000000000000000000000000000560050060000000000000000
00000000556000650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000556000650000000000000000
00000000855066580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000855066580000000000000000
0000000080660068000000000000000000000000000000000000000000000000cc0000cc00000000000000000000000080660068806600680000000000000000
0000000006500655000000000000000000000000000000000000000000000000c000000c00000000000000000000000006500655065006550000000000000000
00000000050000550000000000000000000000000000000000000000000000000000000000000000000000000000000005000055050000550000000000000000
00000000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000066000000660000000000000000000
00000000600655000000000000000000000000000000000000000000000000000000000000000000000000000000000060065500600655000000000000000000
00000000560050060000000000000000000000000000000000000000000000000000000000000000000000000000000056005006560050060000000000000000
0000000055600065000000000000000000000000000000000000000000000000c000000c00000000000000000000000055600065556000650000000000000000
0000000085506658000000000000000000000000000000000000000000000000cc0000cc00000000000000000000000085506658855066580000000000000000
00000000806600680000000000000000000000000000000000000000000000000000000000000000806600688066006880660068000000000000000000000000
00000000065006550000000000000000000000000000000000000000000000000000000000000000065006550650065506500655000000000000000000000000
00000000050000550000000000000000000000000000000000000000000000000000000000000000050000550500005505000055000000000000000000000000
00000000000660000000000000000000000000000000000000000000000000000000000000000000000660000006600000066000000000000000000000000000
00000000600655000000000000000000000000000000000000000000000000000000000000000000600655006006550060065500000000000000000000000000
00000000560050060000000000000000000000000000000000000000000000000000000000000000560050065600500656005006000000000000000000000000
00000000556000650000000000000000000000000000000000000000000000000000000000000000556000655560006555600065000000000000000000000000
00000000855066580000000000000000000000000000000000000000000000000000000000000000855066588550665885506658000000000000000000000000
00000000806600680000000000000000000000000000000000000000806600688066006880660068806600680000000000000000000000000000000000000000
00000000065006550000000000000000000000000000000000000000065006550650065506500655065006550000000000000000000000000000000000000000
00000000050000550000000000000000000000000000000000000000050000550500005505000055050000550000000000000000000000000000000000000000
00000000000660000000000000000000000000000000000000000000000660000006600000066000000660000000000000000000000000000000000000000000
00000000600655000000000000000000000000000000000000000000600655006006550060065500600655000000000000000000000000000000000000000000
00000000560050060000000000000000000000000000000000000000560050065600500656005006560050060000000000000000000000000000000000000000
00000000556000650000000000000000000000000000000000000000556000655560006555600065556000650000000000000000000000000000000000000000
00000000855066580000000000000000000000000000000000000000855066588550665885506658855066580000000000000000000000000000000000000000
00000000806600680000000000000000000000000000000000000000806600680000000000000000000000000000000000000000000000000000000000000000
00000000065006550000000000000000000000000000000000000000065006550000000000000000000000000000000000000000000000000000000000000000
00000000050000550000000000000000000000000000000000000000050000550000000000000000000000000000000000000000000000000000000000000000
00000000000660000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000000000000
00000000600655000000000000000000000000000000000000000000600655000000000000000000000000000000000000000000000000000000000000000000
00000000560050060000000000000000000000000000000000000000560050060000000000000000000000000000000000000000000000000000000000000000
00000000556000650000000000000000000000000000000000000000556000650000000000000000000000000000000000000000000000000000000000000000
00000000855066580000000000000000000000000000000000000000855066580000000000000000000000000000000000000000000000000000000000000000
00000000806600680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000065006550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000050000550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000600655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000560050060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000556000650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000855066580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000806600680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000065006550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000050000550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000600655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000560050060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000556000650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000855066580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0404040404040404040404040404040000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040400000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040400000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040400000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040400000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040400000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040400000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0400000000000000000000000000040004040004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040404040404040004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000230500e050130501a0500a05029050200502e0500905011050330502e050230500a0500f0501105023050210501f0502a05012050160501b050120503705018050230502c05000000000000000000000
