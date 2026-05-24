// Some code is this object is from (while modified a bit)
// Coffee-break Tutorials: Pausing Your Game (GML), Mark Alexander, 20 February 2020
// https://gamemaker.io/en/tutorials/coffee-break-tutorials-pausing-your-game-gml
// Thanks GameMaker!

camerax = camera_get_view_x(view_camera[0]);
cameray = camera_get_view_y(view_camera[0]);

if (freezeframe)
    {
	parrysfx = audio_play_sound(snd_parry_ultrakill, 10, false);
    paused = true;
	freezeframes = 20;
	freezeframe = false;
	pause_selection = 0;
    }
if paused == true
    {
	audio_pause_all();
	audio_resume_sound(parrysfx);
    }

// FREEZEFRAMES
	if (freezeframes > 0) {
		freezeframes -= 1;
		if freezeframes == 0 {
			paused = false;
			instance_activate_all();
			surface_free(paused_surf);
			paused_surf = -1;
			audio_resume_all();
			//audio_resume_sound(global.current_mus); RESUME CURRENT MUSIC
		}
	}