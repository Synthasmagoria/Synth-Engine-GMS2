///@desc Trigger

if (place_meeting(x, y, obj_Player)) {
	
	if (trg_dir != 0) {
		scr_Trigger(trg, trg_dir);
	} else {
		scr_Trigger(trg);
	}
	
	if (trg_snd != -1) {
		audio_play_sound(trg_snd, 0, false);
	}
	
	if (destroy) {
		instance_destroy();
	}
}