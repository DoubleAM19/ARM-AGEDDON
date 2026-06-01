/// @description runs every frame, for drawing

draw_self();

draw_text(100, 100, string(id)+"DEBUG");
draw_text(100, 120, "x="+string(x));
draw_text(100, 140, "y="+string(y));
draw_text(100, 160, "grab_suction_x="+string(grab_suction_x));
draw_text(100, 180, "grab_suction_y="+string(grab_suction_y));
draw_text(100, 200, "external_force_x="+string(external_force_x));
draw_text(100, 220, "external_force_y="+string(external_force_y));
draw_text(100, 220, "touchingfloor="+string(touching_floor));