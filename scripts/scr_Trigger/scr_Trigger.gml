///@desc Triggers triggerable instances
///@func scr_Trigger(index, dir);
///@arg {real} index
///@arg {real} [dir]

if (argument_count == 1) {
	with (obj_TriggerKiller)
		if (trg == argument[0])
			dir *= -1;
			
	with (obj_TriggerBlock)
		if (trg == argument[0])
			dir *= -1;
} else {
	with (obj_TriggerKiller)
		if (trg == argument[0])
			dir = argument[1];
	
	with (obj_TriggerBlock)
		if (trg == argument[0])
			dir = argument[1];
}