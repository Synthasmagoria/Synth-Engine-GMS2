///@descr Calculate Movement

// Reset values
hspeed = 0;
situated = false;

// Horizontal speed & orientation
var orientation = keyboard_check(global.button[BUTTON.RIGHT]) - keyboard_check(global.button[BUTTON.LEFT]);

hspeed += hs_run * orientation;
running = orientation != 0;
facing = running ? orientation : facing;

#region Platforms
var platform = collision_rectangle(
	bbox_left,
	bbox_top,
	bbox_right,
	bbox_bottom + max(vspeed, 1) + frac(y),
	obj_Platform,
	false,
	false
);

if (platform) {
	
	with (platform) {
		event_user(0);
	}
	
	hspeed += platform.hspeed;
	
	if (y < platform.y && 
		!(bbox_bottom < platform.y && vspeed < platform.vspeed) &&
		!place_meeting(x, platform.y - hitbox_y2 - 1, obj_Block)
	) {
		y = platform.y - hitbox_y2 - 1;
		vspeed = platform.vspeed;
		situated = true;
	}
}
#endregion

// Vertical gravity
vspeed = min(vspeed + vs_gravity, vs_max);

// Check for blocks
situated |= (place_meeting(x, y + 1, obj_Block) && (vspeed >= 0));

// refresh secondary jumps
djump_index *= !situated;

#region Water
var water, water_type;
water = instance_place(x, y, obj_Water);

if (water) {
	vspeed = min(vspeed, vs_swim);
	water_type = water.object_index;
} else {
	water_type = -1;
}
#endregion

#region Jump
if (keyboard_check_pressed(global.button[BUTTON.JUMP])) {
	if (situated || water_type == obj_Water1 || platform) {
		situated = false;
		djump_index = 0;
		vspeed = vs_jump;
		audio_play_sound(snd_Jump, 0, false);
	} else if (djump_index < djump_number || water_type == obj_Water2) {
		djump_index++;
		vspeed = vs_djump;
		audio_play_sound(snd_Djump, 0, false);
	}
}
#endregion

// Fall
vspeed = (keyboard_check_released(global.button[BUTTON.JUMP]) && (vspeed < 0)) ? vspeed * vs_fall : vspeed;

#region Shoot
if (keyboard_check_pressed(global.button[BUTTON.SHOOT])) {
	var bullet;
	bullet = instance_create_depth(x, y, depth, obj_Bullet);
	bullet.hspeed *= facing;
	audio_play_sound(snd_Shoot, 0, false);
}
#endregion

#region Block
if (place_meeting(x + hspeed, y + vspeed, obj_Block)) {
	
	var block;
	
	block = instance_place(x + hspeed, y, obj_Block);
	if (block) {
		x = hspeed < 0 ? block.bbox_right - hitbox_x1 + 1 : block.bbox_left - hitbox_x2 - 1;
		hspeed = 0;
	} else {
		x += hspeed;
		hspeed = 0;
	}
	
	block = instance_place(x, y + vspeed, obj_Block);
	if (block) {
		y = vspeed < 0 ? block.bbox_bottom - hitbox_y1 + 1 : block.bbox_top - hitbox_y2 - 1;
		vspeed = 0;
	}
}
#endregion

#region Death
if (place_meeting(x + hspeed, y + vspeed, obj_Killer) || keyboard_check_pressed(global.button[BUTTON.SUICIDE])) {
	scr_KillPlayer();
}
#endregion
