// Some code is this object is from (while modified a bit):
// Coffee-break Tutorials: Pausing Your Game (GML), Mark Alexander, 20 February 2020
// https://gamemaker.io/en/tutorials/coffee-break-tutorials-pausing-your-game-gml
// Thanks GameMaker!

paused = false;
paused_surf = -1;

camerax = camera_get_view_x(view_camera[0]);
cameray = camera_get_view_y(view_camera[0]);

pause_selection = 0;
