/// @description runs every frame

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
	m2 = mouse_check_button(2);
	m2_p = mouse_check_button_pressed(2);

// Horizontal Movement
	move_x = current_move_speed + current_dash_speed + armimpulsepower_x; // horizontal movement calculation

	current_move_speed += (right - left); // add moving left and right influence
	
	if left_p {dir = -1;} // decide which direction player is facing based off of left and right input
	if right_p {dir = 1;}
	
	if current_dash_speed > 0 {current_dash_speed -= 1;} // tick down dash speed
	if current_dash_speed < 0 {current_dash_speed += 1;}
	if (-1 < current_dash_speed and current_dash_speed < 1) {current_dash_speed = 0;} // prevent number resting at a decimal less than 1 but bigger than 0
	
	// Speed caps
	if current_move_speed > move_speed {
		current_move_speed = move_speed;
	}
	if current_move_speed < -move_speed {
		current_move_speed = -move_speed;
	}
	// Slow down
	if (right - left) == 0 {
		if (current_move_speed > 0) {
			current_move_speed -= player_friction;
		}
		if (current_move_speed < 0) {
			current_move_speed += player_friction;
		}
	}
	// Right Wall Collision
	if (collision_rectangle(x+16, y, x+18, y-48, obj_ground, false, true)) {
		touching_right_wall = true;
		if move_x > 0 {
			move_x = 0;
			armimpulsepower_x = 0;
			touched_right_wall = true;
		} else {
			touched_right_wall = false;
		}
		if current_move_speed > 0 {
			current_move_speed = 0;
		}
	} else {
		touching_right_wall = false;
	}
	// Left Wall Collision
	if (collision_rectangle(x-16, y, x-18, y-48, obj_ground, false, true)) {
		touching_left_wall = true;
		if move_x < 0 {
			move_x = 0;
			armimpulsepower_x = 0;
			touched_left_wall = true;
		} else {
			touched_left_wall = false;
		}
		if current_move_speed < 0 {
			current_move_speed = 0;
		}
	} else {
		touching_left_wall = false;
	}
	
// Jumping
	// Buffered input
	if (up_p) {jump_input_buffer = 8;}
	if (jump_input_buffer > 0) {jump_input_buffer -= 1;}
	// Initial boost
	if (up_p/*Jump Input*/ or jump_input_buffer/*buffered jump input*/) and (touching_ground/*currently touching the floor, or*/ or coyote_time > 0/*coyote time is active(4 frames)*/) {
		if (armimpulsepower_x > 5) { // if currently dashing
			current_jump_force = -jump_power * 0.75; // 75% jump power
			current_dash_speed += jump_power * 0.25; // and add 25% of it to horizontal momentum
			audio_play_sound(snd_playerjump, 3, false, 1, 0, random_range(1.4, 1.6)); // sfx
		} else if (armimpulsepower_x < -5) { // if currently dashing other way
			current_jump_force = -jump_power * 0.75; // same
			current_dash_speed += -jump_power * 0.25; // same (other way)
			audio_play_sound(snd_playerjump, 3, false, 1, 0, random_range(1.4, 1.6)); // sfx
		} else {
			current_jump_force = -jump_power; // else normal jump
			audio_play_sound(snd_playerjump, 3, false, 1, 0, random_range(0.9, 1.1)); // sfx
		}
		coyote_time = 0; // reset coyote time
	}
	
	// Ground check
	if collision_rectangle(x - 16, y, x + 16, y + 4, obj_ground, false, true) {
		touching_ground = true;
		fall_speed_multiplier = 1;
		coyote_time = 6; // reset coyote time
		if (current_jump_force > 0) {current_jump_force = 0;}
	} else {
		touching_ground = false;
		if coyote_time > 0 {coyote_time -= 1;}  // tick down coyote time frames
		
		// calculate fall speeds
			if (down and fall_speed_multiplier == 1) { // fast fall
				current_jump_force += 10;
				audio_play_sound(snd_fastfall, 3, false, 1, 0, random_range(0.9, 1.1)); // sfx
				fall_speed_multiplier = 2;
			}
		
			current_jump_force += player_gravity * fall_speed_multiplier; // apply fast fall multiplier
		
			if current_jump_force > max_fall_speed { // fall speed cap
				current_jump_force = max_fall_speed;
			}
	}
	
	//Ceiling Check
	if collision_rectangle(x - 16, y - 48, x + 16, y - 50, obj_ground, false, true) and (current_jump_force < 0) {
		current_jump_force = 0;
	}
	
	move_y = current_jump_force + armimpulsepower_y;
	
// Impulses
	if (m2_p and impulses > 1) {
		armimpulsepower_x = -impulsepower * lengthdir_x(1, point_direction(x, y, mouse_x, mouse_y));
		armimpulsepower_y = -impulsepower * lengthdir_y(1, point_direction(x, y, mouse_x, mouse_y));
		audio_play_sound(snd_impulse, 3, false, 1, 0, random_range(0.9, 1.1)); // sfx
		impulses -= 1;
	}
	
	if (impulses < 5) {impulses += 0.01}
	
	if armimpulsepower_x > 0 {armimpulsepower_x -= impulse_air_resistance;} // tick down impulse speed (x)
	if armimpulsepower_x < 0 {armimpulsepower_x += impulse_air_resistance;}
	if armimpulsepower_y > 0 {armimpulsepower_y -= impulse_air_resistance;} // tick down impulse speed (y)
	if armimpulsepower_y < 0 {armimpulsepower_y += impulse_air_resistance;}

	if (-1 < armimpulsepower_x and armimpulsepower_x < 1) {armimpulsepower_x = 0;} // prevent number resting at a decimal less than 1 but bigger than 0
	if (-1 < armimpulsepower_y and armimpulsepower_y < 1) {armimpulsepower_y = 0;}
	
// Move and Collide
	move_and_collide(move_x, move_y, obj_ground);