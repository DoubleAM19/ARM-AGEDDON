/// @description runs apon object creation

// Variables
	//REAL
	move_x = 0;
	move_y = 0;
	
	jump_power = 15;
	move_speed = 7;
	current_move_speed = 0;
	current_jump_force = 0;
	player_friction = 1;
	player_gravity = 1;
	
	coyote_time = 0; // timer for how long you can still jump for after leaving the ground (6 frames)
	jump_input_buffer = 8; // timer for how long you can still get a jump if you pressed it before touching the floor (8 frames)
	max_fall_speed = 40;
	fall_speed_multiplier = 1;
	
	dir = 1; // direction currently facing, -1 or 1
	
	current_dash_speed = 0;
	
	collidable_objs = [obj_ground, obj_projectileblock];
	
	// ARM
	armdir = 0;
	impulsepower = 15; 
	armimpulsepower_x = 0;
	armimpulsepower_y = 0;
	impulse_air_resistance = 0.5;
	impulses = 5;
	
	sucked_obj = noone;
	held_obj = noone;
	holding_obj = false;
	held_obj_launch_cooldown = 0;
	
	//BOOL
	touching_ground = false
	touching_right_wall = false;
	touching_left_wall = false;
	touched_right_wall = false;
	touched_left_wall = false;
	
	//STRING
	state = "idle"
	
	//CONTROLS
	up = keyboard_check(vk_space);
	up_p = keyboard_check_pressed(vk_space);
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	left_p = keyboard_check_pressed(ord("A"));
	right = keyboard_check(ord("D"));
	right_p = keyboard_check_pressed(ord("D"));
	dash = keyboard_check(vk_shift);
	m1 = mouse_check_button(1);
	m1_p = mouse_check_button_pressed(1);
	m1_r = mouse_check_button_released(1);
	m2 = mouse_check_button(2);
	m2_p = mouse_check_button_pressed(2);

	window_set_fullscreen(true);	
	//window_set_cursor(cr_none);
	//cursor_sprite = spr_crosshair;