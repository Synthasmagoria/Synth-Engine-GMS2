///@desc Initialize Variables

// Make sure not to have multiple, nor to initialize twice
if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

// Randomize
randomize();

// Set audio group macros
#macro AUDIOGROUP_MUSIC audiogroup_default
#macro AUDIOGROUP_SOUND audiogroup_sound

// Initialize sound effects
if (!audio_group_is_loaded(AUDIOGROUP_SOUND)) {
	audio_group_load(AUDIOGROUP_SOUND);
}

// Set config file macros
#macro CONFIG_FILENAME "config.ini"

#macro CONFIG_SECTION_BUTTONS "B"
#macro CONFIG_SECTION_SETTINGS "S"

// Set game macros
#macro GAME_WIDTH 800
#macro GAME_HEIGHT 608

// Global array enumerators
enum BUTTON {
	RIGHT,
	UP,
	LEFT,
	DOWN,
	JUMP,
	SHOOT,
	RETRY,
	PAUSE,
	SUICIDE,
	NUMBER
}

enum BUTTON_MENU {
	RIGHT,
	UP,
	LEFT,
	DOWN,
	ACCEPT,
	DECLINE,
	MENU,
	NUMBER
}

enum BUTTON_WORLD {
	MENU,
	QUIT,
	FULLSCREEN,
	SCREENSHOT,
	NUMBER
}

enum SETTING {
	FULLSCREEN,
	SMOOTHING,
	SCALE,
	FRAMERATE,
	MUSIC,
	SOUND,
	NUMBER
}

enum SAVE {
	X,
	Y,
	ROOM,
	DEATH,
	TIME,
	NUMBER
}

// Default buttons
global.button_default = array_create(BUTTON.NUMBER);
global.button_default[BUTTON.RIGHT] = vk_right;
global.button_default[BUTTON.UP] = vk_up;
global.button_default[BUTTON.LEFT] = vk_left;
global.button_default[BUTTON.DOWN] = vk_down;
global.button_default[BUTTON.JUMP] = vk_shift;
global.button_default[BUTTON.SHOOT] = ord("Z");
global.button_default[BUTTON.RETRY] = ord("R");
global.button_default[BUTTON.PAUSE] = ord("P");
global.button_default[BUTTON.SUICIDE] = ord("Q");

// Menu navigation buttons
global.button_menu = array_create(BUTTON_MENU.NUMBER);
global.button_menu[BUTTON_MENU.RIGHT] = vk_right;
global.button_menu[BUTTON_MENU.UP] = vk_up;
global.button_menu[BUTTON_MENU.LEFT] = vk_left;
global.button_menu[BUTTON_MENU.DOWN] = vk_down;
global.button_menu[BUTTON_MENU.ACCEPT] = vk_shift;
global.button_menu[BUTTON_MENU.DECLINE] = ord("Z");

// World control buttons
global.button_world = array_create(BUTTON_WORLD.NUMBER);
global.button_world[BUTTON_WORLD.MENU] = vk_f2;
global.button_world[BUTTON_WORLD.QUIT] = vk_escape;
global.button_world[BUTTON_WORLD.FULLSCREEN] = vk_f4;
global.button_world[BUTTON_WORLD.SCREENSHOT] = vk_f11;

// Default settings
global.setting_default = array_create(SETTING.NUMBER);
global.setting_default[SETTING.FULLSCREEN] = false;
global.setting_default[SETTING.SMOOTHING] = false;
global.setting_default[SETTING.SCALE] = 1;
global.setting_default[SETTING.FRAMERATE] = 60;
global.setting_default[SETTING.MUSIC] = 1;
global.setting_default[SETTING.SOUND] = 1;

// Game variables
global.game_playing = false; // variable to check if the game is not in the menu
global.game_paused = false; // variable to check if the game is paused
window_set_caption("GMS2 Engine");

// Save values
global.save = array_create(SAVE.NUMBER);
global.save_active = array_create(SAVE.NUMBER);
global.save_index = 0;
global.save_number = 3;

// Default save values (used when starting a new game)
global.save_default = array_create(SAVE.NUMBER);
global.save_default[SAVE.X] = 128;
global.save_default[SAVE.Y] = 128;
global.save_default[SAVE.ROOM] = rm_Stage;

// Write default buttons & settings to config file if it doesn't exist
if (!file_exists(CONFIG_FILENAME)) {
	
	ini_open(CONFIG_FILENAME);
	
	for (var i = 0; i < BUTTON.NUMBER; i++)
		ini_write_real(CONFIG_SECTION_BUTTONS, i, global.button_default[i]);
		
	for (var i = 0; i < SETTING.NUMBER; i++)
		ini_write_real(CONFIG_SECTION_SETTINGS, i, global.setting_default[i]);
	
	ini_close();
}

// Read buttons & settings from config
global.button = array_create(BUTTON.NUMBER);
global.setting = array_create(SETTING.NUMBER);

ini_open(CONFIG_FILENAME);

for (var i = 0; i < BUTTON.NUMBER; i++)
	global.button[i] = ini_read_real(CONFIG_SECTION_BUTTONS, i, 0);

for (var i = 0; i < SETTING.NUMBER; i++)
	global.setting[i] = ini_read_real(CONFIG_SECTION_SETTINGS, i, 0);
	
ini_close();

// FPS variables
#macro FPS_BASE 50
#macro FPS_MULTIPLIER_CALCULATION FPS_BASE / global.setting[SETTING.FRAMERATE]
#macro FPS_MULTIPLIER_CALCULATION_SQUARED power(FPS_MULTIPLIER_CALCULATION, 2)
//global.fps_calculation = FPS_MULTIPLIER_CALCULATION;
//global.fps_calculation_squared = FPS_MULTIPLIER_CALCULATION_SQUARED;

// Set settings according to file or defaults
for (var i = 0; i < SETTING.NUMBER; i++) {
	scr_SettingSet(i, global.setting[i]);
}

// Player variables
global.player_depth = 1;
global.player_blood_depth = -1;

// Pause variables
pause_surface = -1;
pause_dim = 0.75;

// Sound variables
sound_index = -1;
sound_id = -1;

// Done initializing
room_goto_next();