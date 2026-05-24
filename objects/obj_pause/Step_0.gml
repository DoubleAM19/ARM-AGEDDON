// Some code is this object is from (while modified a bit)
// Coffee-break Tutorials: Pausing Your Game (GML), Mark Alexander, 20 February 2020
// https://gamemaker.io/en/tutorials/coffee-break-tutorials-pausing-your-game-gml
// Thanks GameMaker!

camerax = camera_get_view_x(view_camera[0]);
cameray = camera_get_view_y(view_camera[0]);

//if !(room == rm_mainmenu)
//{
if keyboard_check_pressed(vk_escape)
    {
    paused = !paused;
	pause_selection = 0;
    if paused == false
        {
        instance_activate_all();
        surface_free(paused_surf);
        paused_surf = -1;
		//audio_resume_sound(global.current_mus); RESUME CURRENT MUSIC
		}
    }
if paused == true
    {
    //alarm[0]++; // PAUSE ALARMS
    //alarm[1]++;
	audio_pause_all();
    }
//}

// PAUSE MENU :
if (paused) {
	if keyboard_check_pressed(vk_left) { // Selection
		pause_selection -= 1;
		if (pause_selection < 0) {
			pause_selection = 2;
		}
	}
	if keyboard_check_pressed(vk_right) {
		pause_selection += 1;
		if (pause_selection > 2) {
			pause_selection = 0;
		}
	}
/*	PAUSE MENU BEHAVIOR
	if keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("X")) {
		// Unpause
		paused = false;
		instance_activate_all();
		surface_free(paused_surf);
		paused_surf = -1;
		audio_resume_sound(global.current_mus);
		obj_cutscenehandler.ping = true;
		if (pause_selection == 1) { // >RESTART
			// Restart
			obj_screeneffects.fadeenabled = false;
			obj_screeneffects.border_visible = false;
			obj_musichandler.player_dead = false;
			obj_screeneffects.arrowin_activate = true;
			global.player_dead = false;
			room_restart();
			
			// Reset Cutscene
			obj_cutscenehandler.cutscene_active = false;
			obj_cutscenehandler.step = 0;
			obj_cutscenehandler.cutscene = 0;
		}
		if (pause_selection == 2) { // >QUIT
			// Reset Cutscene
			obj_cutscenehandler.cutscene_active = false;
			obj_cutscenehandler.step = 0;
			obj_cutscenehandler.cutscene = 0;
			
			// Quit
			obj_screeneffects.fadeenabled = false;
			obj_musichandler.player_dead = false;
			obj_screeneffects.border_visible = false;
			obj_gamelogic.nextroom = rm_levelselect;
			global.player_dead = false;
			global.music_state = "none";
			audio_pause_sound(global.current_mus);
			room_goto(rm_loadingzone);
		}
	}
*/
}