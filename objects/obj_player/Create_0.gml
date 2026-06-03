/// @description runs apon object creation

// Variables
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
	
	collidable_objs = [obj_ground]; // objects the player collides with
	
	holding_obj = false; // true if player currently has an object in their hand
	held_obj = noone; // the id of the currently held obj
	held_obj_x_target = 0; // x value of the held obj
	held_obj_y_target = 0; // y value of the held obj
	held_obj_interp = 1;
	throw_cooldown = 0;
	
	dashroll_extraspeed = 4;
	
	touching_ground = false
	touching_right_wall = false;
	touching_left_wall = false;
	touched_right_wall = false;
	touched_left_wall = false;
	
	//CONTROLS
	jump = keyboard_check(vk_space);
	jump_p = keyboard_check_pressed(vk_space);
	up = keyboard_check(vk_up);
	down = keyboard_check(vk_down);
	left = keyboard_check(vk_left);
	left_p = keyboard_check_pressed(vk_left);
	right = keyboard_check(vk_right);
	right_p = keyboard_check_pressed(vk_right);
	dashroll = keyboard_check(vk_shift);
	dashroll_p = keyboard_check_pressed(vk_shift);
	pickup = keyboard_check(ord("Z"));
	pickup_p = keyboard_check_pressed(ord("Z"));
	pickup_r = keyboard_check_released(ord("Z"));

	window_set_fullscreen(true);	
	//window_set_cursor(cr_none);
	//cursor_sprite = spr_crosshair;
	
// HORIZONTAL STATES
	// NORMAL - the state the player is in normally. allows side to side movement at a medium speed
	horizstate_normal = function()
	{
		current_move_speed += (right - left) * 2; // add moving left and right influence
	
		if left_p {dir = -1;} // decide which direction player is facing based off of left and right input
		if right_p {dir = 1;}
	
		// Speed caps
		if current_move_speed > move_speed {
			current_move_speed = move_speed;
		}
		if current_move_speed < -move_speed {
			current_move_speed = -move_speed;
		}
		
		// Slow down
		if (right - left) == 0 {
			if (-1 < current_move_speed and current_move_speed < 1) {current_move_speed = 0;}// prevent number resting at a decimal less than 1 but bigger than 0
			if (current_move_speed > 0) {
				current_move_speed -= player_friction;
			}
			if (current_move_speed < 0) {
				current_move_speed += player_friction;
			}
		}
		
		// prevent number resting at a decimal less than 1 but bigger than 0
		if (-1 < current_move_speed and current_move_speed < 1) {current_move_speed = 0;}
	}
	
	// DASHROLL - a state that can be entered by pressing [dashroll], harder to turn around, but a higher top speed
	// TODO
	/*
	- make max speed slowly go back to normal instead of snapping
	- less jump height when dashrolling
	- when dashroll starts, dash forward if in the air (and up a bit)
	*/
	horizstate_dashroll = function()
	{
		current_move_speed += (right - left) * 0.5; // add moving left and right influence
	
		if left_p {dir = -1;} // decide which direction player is facing based off of left and right input
		if right_p {dir = 1;}
	
		// Speed caps
		if current_move_speed > (move_speed + dashroll_extraspeed) {
			current_move_speed = (move_speed + dashroll_extraspeed);
		}
		if current_move_speed < -(move_speed + dashroll_extraspeed) {
			current_move_speed = -(move_speed + dashroll_extraspeed);
		}
		
		// Slow down
		if (right - left) == 0 {
			if (-1 < current_move_speed and current_move_speed < 1) {current_move_speed = 0;}// prevent number resting at a decimal less than 1 but bigger than 0
			if (current_move_speed > 0) {
				current_move_speed -= player_friction;
			}
			if (current_move_speed < 0) {
				current_move_speed += player_friction;
			}
		}
	}
	
	// FROZEN - no code runs
	horizstate_frozen = function()
	{}
	
	animation_state = "idle"
	horizontal_state = horizstate_normal; // can be horizstate_normal, horizstate_frozen, or horizstate_dashroll(defined above)
	
	_image_angle = 0; // placeholder