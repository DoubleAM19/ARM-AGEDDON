
hpvisualx = 0;
for (i = 0; i < obj_player_old.totalhp; i++) {
	draw_sprite(spr_crosshair, 1, camera_get_view_x(view_camera[0]) + 40 + hpvisualx, camera_get_view_y(view_camera[0]) + 40);
	hpvisualx += 40;
}
