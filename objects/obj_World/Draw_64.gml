///@desc Pause screen

if (global.game_paused) {
	if (!surface_exists(pause_surface)) {
		pause_surface = surface_create(GAME_WIDTH, GAME_HEIGHT);
		surface_set_target(pause_surface);
		
		draw_set_color(c_black);
		draw_set_alpha(pause_dim);
		draw_rectangle(0, 0, GAME_WIDTH, GAME_HEIGHT, false);
		draw_set_color(c_white);
		draw_set_alpha(1.0);
		
		draw_text(0, 0, "DEATH: " + string(global.save_active[SAVE.DEATH]));
		draw_text(0, 16, "TIME: " + scr_TimeToString(global.save_active[SAVE.TIME]));
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed(GAME_WIDTH / 2, GAME_HEIGHT / 2, "PAUSE", 1, 1, 0);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		surface_reset_target();
	}
	
	draw_surface_ext(pause_surface, 0, 0, 1, 1, 0, c_white, 1);
}