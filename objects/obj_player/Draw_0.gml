/// @description runs every frame, for drawing

draw_self();

if (dir == 1) {
	image_xscale = 1;
} else {
	image_xscale = -1;
}

/*
draw_rectangle(x - 32, y - 64, x + 32, y - 66, false)
draw_rectangle(x - 32, y, x + 32, y + 2, false)
draw_rectangle(x+32, y, x+34, y-64, false)
draw_rectangle(x-32, y, x-34, y-64, false)
*/