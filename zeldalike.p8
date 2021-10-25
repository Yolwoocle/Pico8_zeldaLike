pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
function _init()
	init_player()
	init_bullet()
end

function _update60()
 mouse_x_y()
	update_bullet()
	player_update()
	for i in all(player) do
	 if (btn(🅾️)) spawn_bullet(i.x,i.y,1,1)
 end
end

function _draw()
 cls()
	draw_bullet()
	draw_mouse()
	draw_player()
	print(xy)
end
-->8
--player
function init_player()
	player={}
	add(player,{nb_player=1,x=64,y=64})
end

function player_update()
	for i in all(player) do
	 if (btn(⬅️)) i.x-=1
	 if (btn(➡️)) i.x+=1
	 if (btn(⬆️)) i.y-=1
	 if (btn(⬇️)) i.y+=1
	end  
end

function draw_player()
 for i in all(player) do
  spr(3,i.x,i.y)
 end
end

-->8
--bullet
function init_bullet()
	bullet = {}
end

function spawn_bullet(x,y,type_bullet,speed)
 xy = get_traj(x,y,mouse_x,mouse_y)
 traj_x = xy.x
 traj_y = xy.y
	add(bullet,{x=x,y=y,type_bullet=type_bullet,speed=speed,traj_x=traj_x,traj_y=traj_y})
	
end

function update_bullet()
	for i in all(bullet) do
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
	angle=atan2(x_end-x_satr, y_end-y_start)
	return {x = cos(angle),y = sin(angle)}
end

function draw_mouse()
	spr(2,mouse_x,mouse_y)
end

__gfx__
000000000000000000000777cc0000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ffffff000077766c000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700fffff72f0077766600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700027ffffff0776666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ffffffff0766600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700ff877fff0244000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff88cff024400000c000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000fffcf0044000000cc0000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000288700001cc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000082280000c11c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000082280000c11c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000288200001cc10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000bbbbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000bbbbbbbb77000000000bbbb00000000000000000000000000000000000000000000bbbb000000000000000000000000000000000000000000000000000000
00bbb3bbbbbb77000000bbbbbbb7000000000bbbbbb0000000000bbbbb0000000000bbbbbbb70000000000000000000000000000000000000000000000000000
00bbbbb3333bbb70000bbbbbbbbb7700000bbbbbbbb7770000bbbbbbbbb7700000bbbbbbbbbb7700000000000000000000000000000000000000000000000000
0bbbb3333333bbb000b3bbbbbbbbbbb00bbbbbbbbbbb3b700bbbbbbbbbbbb70000b3bbbbbbbbbbb0000000000000000000000000000000000000000000000000
0bbbb3333333bbb00bbbb33333bbbbb00bbbbbb333bbbbbbbbbbb33bb333bbb000bbb33333bbbbb0000000000000000000000000000000000000000000000000
bbbb333333333bb0bbbb3333333bb3bbbb3bb33333333bbbb3bb33333333b3bb0bbb3333333bb3bb000000000000000000000000000000000000000000000000
bbbb333333333bbbbbbb33333333bbbbbbbb333333333bbbbbbb33333333bbbb0bbb33333333bbbb000000000000000000000000000000000000000000000000
bb3bb3333333bb3bbbb3b333333bbbbbbbbbb3333333bbbbbbbbb333333bbbbbbbb3b333333bbbbb000000000000000000000000000000000000000000000000
bbbbbbb3b3bbbbbbbbbbbb3bbbbbbbbbbb3bbbbb3bbbbbbbbb3bbb3bbbbbbbbbbbbbbb3bb3bbbbbb000000000000000000000000000000000000000000000000
00bbbbbbbbbbbb000bbbbbbbbbbbbb000bbbbbbbbbbbbbb00bbbbbbbbbbbbb000bbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000067000000000000000000000000000000000000000000000000
00288000000028800000000000000000002880000000288000000000000000000000000000000667000000000000000000000000000000000000000000000000
02888000000028880028800000002880028880000000288800288000000028800000000000006770000000000000000000000000000000000000000000000000
02800000000000280288800000002888028000000000002802888000000028880000000000066700000000000000000000000000000000000000000000000000
02800070007000280280000000000028028000700070002802800000000000280000000000667000000000000000000000000000000000000000000000000000
0288008000802888028000700070002802880080008028880280007000700028000000000667000000000ddd0000d60000000000000000000000000000000000
0280000808000028028800080800288802800008080000280288008000802888000000006670000000d665556666660000000000000000000000000000000000
0280028888880280028000080800002802800288888802800280000808000028000000066700000006666ddd6666660000000000000000000000000000000000
02888888888888800280028888880280028888888888888002800288888802800000006770000000000d655566ddd00000000000000000000000000000000000
00288882828880000288888888888880002888828288800002888888888888800000066700000000000d6dd66000000000000000000000000000000000000000
00028828882880000028888282888000000288288828800000288882828880000001117000000000000444406000000000000000000000000000000000000000
00028888888880000002882888288000000288888888800000028828882880000002110000000000004444260000000000000000000000000000000000000000
00028888288880000002888888888000000288882888800000028888888880000026410000000000044422000000000000000000000000000000000000000000
02880288888028800002888828888000028802888880288000028888288880000244000000000000044200000000000000000000000000000000000000000000
02880000000028800288028888802880028800000000288002880288888028802640000000000000044420000000000000000000000000000000000000000000
