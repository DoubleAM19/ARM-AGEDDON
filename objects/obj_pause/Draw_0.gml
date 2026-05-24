// Some code is this object is from (while modified a bit)
// Coffee-break Tutorials: Pausing Your Game (GML), Mark Alexander, 20 February 2020
// https://gamemaker.io/en/tutorials/coffee-break-tutorials-pausing-your-game-gml
// Thanks GameMaker!

if paused == true
{
if !surface_exists(paused_surf)
    {
    if paused_surf == -1
        {
		//audio_pause_sound(global.current_mus); PAUSE CURRENT MUSIC
        instance_deactivate_all(true);
		//instance_activate_object(obj_); <-- put objects that should always be active here
        }
    paused_surf = surface_create(room_width, room_height);
    surface_set_target(paused_surf);
    draw_surface(application_surface, camerax, cameray);
    surface_reset_target();
    }
	else
    {
    draw_surface(paused_surf, 0, 0);
    draw_set_alpha(0.5);
    draw_rectangle_colour(camerax, cameray, room_width, room_height, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_text_transformed_colour(camerax + (camera_get_view_width(view_camera[0]) / 2), cameray + (camera_get_view_height(view_camera[0]) / 2) - 100, "PAUSED", 2, 2, 0, c_white, c_white, c_white, c_white, 1);
	if (pause_selection == 0) {
		draw_text_transformed_colour(camerax + (camera_get_view_width(view_camera[0]) / 2), cameray + (camera_get_view_height(view_camera[0]) / 2) + 100, 
		">RESUME    RESTART    QUIT", 
		2, 2, 0, c_white, c_white, c_white, c_white, 1);
	} else if (pause_selection == 1) {
		draw_text_transformed_colour(camerax + (camera_get_view_width(view_camera[0]) / 2), cameray + (camera_get_view_height(view_camera[0]) / 2) + 100, 
		" RESUME   >RESTART    QUIT", 
		2, 2, 0, c_white, c_white, c_white, c_white, 1);
	} else if (pause_selection == 2) {
		draw_text_transformed_colour(camerax + (camera_get_view_width(view_camera[0]) / 2), cameray + (camera_get_view_height(view_camera[0]) / 2) + 100, 
		" RESUME    RESTART   >QUIT", 
		2, 2, 0, c_white, c_white, c_white, c_white, 1);
	}
    draw_set_halign(fa_left);
    }
}