///@desc Save time
if (global.game_playing) {
	scr_SaveGame(SAVE.DEATH, SAVE.TIME);
	scr_WriteGame(string(global.save_index));
}

global.game_playing = false;
global.game_paused = false;