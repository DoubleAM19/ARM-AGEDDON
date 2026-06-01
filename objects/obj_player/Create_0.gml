/// @description runs apon object creation

// Variables
	//REAL
	move_x = 0; // horizontal momentum
	move_y = 0; // vertical momentum
	
	jump_power = 11; // amount added to move_y when a jump is performed
	move_speed = 7; // amount added to move_x when walking
	current_move_speed = 0; // current walking speed
	current_jump_force = 0; // force of the current jump added to the vertical movement calculation
	player_friction = 1; // how fast the horizontal movement fades, this is technically friction and horzontal air resistance
	player_gravity = 1; // how much you are pulled down, its gravity bruh
	
	coyote_time = 0; // timer for how long you can still jump for after leaving the ground (6 frames)
	jump_input_buffer = 8; // timer for how long you can still get a jump if you pressed it before touching the floor (8 frames)
	max_fall_speed = 40; // the limit for how fast you can fall
	fall_speed_multiplier = 1; // this increases gravity with a multiplier
	
	dir = 1; // direction currently facing, -1 or 1
	
	current_dash_speed = 0; // not used
	
	collidable_objs = [obj_ground]; // objects the player collides with
	
	holding_obj = false; // true if player currently has an object in their hand
	held_obj = noone; // the id of the currently held obj
	held_obj_x_target = 0; // x value of the held obj
	held_obj_y_target = 0; // y value of the held obj
	held_obj_interp = 1;
	
	//BOOL
	touching_ground = false
	touching_right_wall = false;
	touching_left_wall = false;
	touched_right_wall = false;
	touched_left_wall = false;
	
	//STRING
	state = "idle"
	
	//CONTROLS
	jump = keyboard_check(vk_space);
	jump_p = keyboard_check_pressed(vk_space);
	up = keyboard_check(vk_up);
	down = keyboard_check(vk_down);
	left = keyboard_check(vk_left);
	left_p = keyboard_check_pressed(vk_left);
	right = keyboard_check(vk_left);
	right_p = keyboard_check_pressed(vk_left);
	dash = keyboard_check(vk_shift);

	window_set_fullscreen(true);	
	//window_set_cursor(cr_none);
	//cursor_sprite = spr_crosshair;