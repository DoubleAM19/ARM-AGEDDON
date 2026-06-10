 /// @description runs every frame, for drawing

// Facing dir

// DEBUG

draw_text(100, 100, string(id)+"DEBUG");
draw_text(100, 120, "x="+string(x));
draw_text(100, 140, "y="+string(y));
draw_text(100, 180, "current_dash_speed_x="+string(current_dash_speed_x));
draw_text(100, 200, "current_dash_speed_y="+string(current_dash_speed_y));
draw_text(100, 160, "state="+string(animation_state));
draw_text(100, 220, "current_move_speed=="+string(current_move_speed));

/*
draw_rectangle(x+16, y, x+17, y-32, false)
draw_rectangle(x-16, y, x-17, y-32, false)
draw_rectangle(x - 16, y, x + 16, y + 4, false)
draw_rectangle(x - 16, y - 32, x + 16, y - 34, false)

draw_rectangle(x - 4, y + 12, x + 4, y + 20, false)
draw_rectangle(x + (24*dir), y - 8, x + (40*dir), y - 24, false)
*/

/*
draw_circle(x + lengthdir_x(128, point_direction(x, y-32, mouse_x, mouse_y)), y-32 + lengthdir_y(128, point_direction(x, y-32, mouse_x, mouse_y)), 64, false);
draw_circle(x + lengthdir_x(48, point_direction(x, y-32, mouse_x, mouse_y)), y-32 + lengthdir_y(48, point_direction(x, y-32, mouse_x, mouse_y)), 32, false);
*/
//draw_self();
draw_sprite_ext(main_sprite, main_index, x, y, dir, 1, 0, c_white, 1);