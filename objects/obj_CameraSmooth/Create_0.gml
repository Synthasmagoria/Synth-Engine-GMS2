///@desc Initialize

camera = camera_create_view(0, 0, GAME_WIDTH, GAME_HEIGHT);
object = obj_Player;

view_camera[0] = camera;
view_visible[0] = true;
view_enabled = true;

view_x_max = room_width - GAME_WIDTH;
view_y_max = room_height - GAME_HEIGHT;
view_x_offset = -GAME_WIDTH / 2;
view_y_offset = -GAME_HEIGHT / 2;