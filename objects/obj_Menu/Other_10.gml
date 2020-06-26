///@desc Save value strings

if (scr_ReadGame(string(option_index))) {
	save_value[0] = string(global.save[SAVE.DEATH]);
	save_value[1] = scr_TimeToString(global.save[SAVE.TIME]);
} else {
	save_value[0] = "0";
	save_value[1] = "00 : 00 : 00";
}