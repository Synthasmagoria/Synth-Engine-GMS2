///@func scr_SettingSet(index, val)
///@desc Change a setting and save it to 'CONFIG_FILENAME'
///@arg {real} index
///@arg {real} value

switch (argument[0]) {
	case SETTING.FULLSCREEN:
	global.setting[argument[0]] = argument[1];
	window_set_fullscreen(global.setting[argument[0]]);
	
	if (argument[1]) {
		window_set_size(GAME_WIDTH, GAME_HEIGHT);
		window_set_position(display_get_width() / 2 - GAME_WIDTH / 2, display_get_height() / 2 - GAME_HEIGHT / 2);
	} else {
		var w = GAME_WIDTH * global.setting[SETTING.SCALE], h = GAME_HEIGHT * global.setting[SETTING.SCALE];
		window_set_size(w, h);
		window_set_position(display_get_width() / 2 - w / 2, display_get_height() / 2 - h / 2);
	}
	break;
	
	case SETTING.SMOOTHING:
	global.setting[argument[0]] = argument[1];
	gpu_set_tex_filter(argument[1]);
	break;
	
	case SETTING.SCALE:
	global.setting[argument[0]] = argument[1];
	var w = GAME_WIDTH * argument[1], h = GAME_HEIGHT * argument[1];
	window_set_size(w, h);
	window_set_position(display_get_width() / 2 - w / 2, display_get_height() / 2 - h / 2);
	break;
	
	case SETTING.FRAMERATE:
	global.setting[argument[0]] = argument[1];
	global.fps_calculation = FPS_MULTIPLIER_CALCULATION;
	global.fps_calculation_squared = FPS_MULTIPLIER_CALCULATION_SQUARED;
	game_set_speed(global.setting[argument[0]], gamespeed_fps);
	break;
	
	case SETTING.MUSIC:
	global.setting[argument[0]] = clamp(argument[1], 0, 1);
	audio_group_set_gain(AUDIOGROUP_MUSIC, global.setting[argument[0]], 0);
	break;
	
	case SETTING.SOUND:
	global.setting[argument[0]] = clamp(argument[1], 0, 1);
	audio_group_set_gain(AUDIOGROUP_SOUND, global.setting[argument[0]], 0);
	break;
	
	default:
	exit;
	break;
}

ini_open(CONFIG_FILENAME);
ini_write_real(CONFIG_SECTION_SETTINGS, argument[0], global.setting[argument[0]]);
ini_close();