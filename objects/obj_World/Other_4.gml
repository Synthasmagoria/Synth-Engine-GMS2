///@desc Room music / tile collision

// Set room music
var sound;

switch (room) {
	case rm_Stage:
		sound = mus_Stage;
		break;
	
	default:
		sound = -1;
		break;
}

if (sound_id != sound) {
	
	if (audio_is_playing(sound_index)) {
		audio_stop_sound(sound_index);
	}
	
	if (sound != -1) {
		sound_index = audio_play_sound(sound, 0, true);
	}
	
	sound_id = sound;
}