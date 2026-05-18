/// @description runs every frame, for drawing

draw_self();

// Facing dir
if (dir == 1) {
	image_xscale = 1;
} else {
	image_xscale = -1;
}

draw_sprite_ext(spr_test1, 1, x, y-32, 1, 1, point_direction(x, y-32, mouse_x, mouse_y)-90, c_red, 1);

// DEBUG
draw_text(100, 100, string(id)+"DEBUG");
draw_text(100, 120, "x="+string(x));
draw_text(100, 140, "y="+string(y));
draw_text(100, 160, "armimpulsepower_x="+string(armimpulsepower_x));
draw_text(100, 180, "armimpulsepower_y="+string(armimpulsepower_y));
draw_text(100, 200, "impulses=="+string(impulses));

draw_rectangle(x+16, y, x+18, y-48, false)
draw_rectangle(x-16, y, x-18, y-48, false)
draw_rectangle(x - 16, y, x + 16, y + 4, false)
draw_rectangle(x - 16, y - 48, x + 16, y - 50, false)
