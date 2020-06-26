///@desc Draw player

// Set sprite
if (situated) {
	sprite_index = !running ? spr_PlayerIdle : spr_PlayerRun;
} else {
	sprite_index = vspeed < 0 ? spr_PlayerJump : spr_PlayerFall;
}

// Draw sprite
draw_sprite_ext(
	sprite_index,
	image_index,
	round(x) - hitbox_xoffset + sprite_width * (facing == -1) + 1,
	round(y) - hitbox_yoffset,
	facing,
	1,
	0,
	c_white,
	1.0
);