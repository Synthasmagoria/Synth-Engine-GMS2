///@desc Window/Game control

if (global.game_playing) {
	
	// Pause
	if (keyboard_check_pressed(global.button[BUTTON.PAUSE])) {
		global.game_paused = !global.game_paused;
		
		if (global.game_paused) {
			instance_deactivate_all(true);
		} else {
			instance_activate_all();
		}
		
		if (surface_exists(pause_surface)) {
			surface_free(pause_surface);
		}
	}
	
	if (!global.game_paused) {
		// Do time
		global.save_active[SAVE.TIME] += 1 / global.setting[SETTING.FRAMERATE];
		
		// Retry
		if (keyboard_check_pressed(global.button[BUTTON.RETRY])) {
			scr_SaveGame(SAVE.DEATH, SAVE.TIME);
			scr_LoadGame();
		}
	}
}

// Main menu
if (keyboard_check_pressed(global.button_world[BUTTON_WORLD.MENU])) {
	game_restart();
}

// Quit
if (keyboard_check_pressed(global.button_world[BUTTON_WORLD.QUIT])) {
	game_end();
}

// Fullscreen
if (keyboard_check_pressed(global.button_world[BUTTON_WORLD.FULLSCREEN])) {
	scr_SettingSet(SETTING.FULLSCREEN, !global.setting[SETTING.FULLSCREEN]);
	
	// Set menu text in case of changing fullscreen
	if (instance_exists(obj_Menu)) {
		obj_Menu.setting[0] = global.setting[SETTING.FULLSCREEN] ? "true" : "false";
	}
}

// Screenshot
if (keyboard_check_pressed(global.button_world[BUTTON_WORLD.SCREENSHOT])) {
	screen_save("screenshot.png");
}