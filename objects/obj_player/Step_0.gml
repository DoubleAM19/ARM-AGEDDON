/// @description runs every frame

//CONTROLS
	up = keyboard_check(vk_space);
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	left_p = keyboard_check_pressed(ord("A"));
	right = keyboard_check(ord("D"));
	right_p = keyboard_check_pressed(ord("D"));
	dash = keyboard_check(vk_shift);
	m1 = mouse_check_button(1);

// Horizontal Movement
	move_x = current_move_speed + current_dash_speed; // horizontal movement calculation

	current_move_speed += (right - left) * 2; // add moving left and right influence
	
	if left_p {dir = -1;} // decide which direction player is facing based off of left and right input
	if right_p {dir = 1;}
	
	// Dashing
	if (dash and dash_cooldown == 0) { // is dash pressed?
		if (left and right) or (not left and not right) { // if both left and right are pressed or neither are
			if (dir == -1) { // go based on direction facing instead
				current_dash_speed = -20;
			}
			if (dir == 1) {
				current_dash_speed = 20;
			}
		} else { // else, go based on current left or right input pressed
			if (left) {
				current_dash_speed = -20;
			} else if (right) {
				current_dash_speed = 20;
			}
		}
		dash_cooldown = 20;
	}
	
	if dash_cooldown > 0 {dash_cooldown -= 1;} // tick down dash cooldown
	if current_dash_speed > 0 {current_dash_speed -= 1;} // tick down dash speed
	if current_dash_speed < 0 {current_dash_speed += 1;}
	
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
			current_move_speed -= 1;
		}
		if (current_move_speed < 0) {
			current_move_speed += 1;
		}
	}
	// Right Wall Collision
	if (collision_rectangle(x+32, y, x+34, y-64, obj_ground, false, true)) {
		touching_right_wall = true;
		if move_x > 0 {
			move_x = 0;
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
	if (collision_rectangle(x-32, y, x-34, y-64, obj_ground, false, true)) {
		touching_left_wall = true;
		if move_x < 0 {
			move_x = 0;
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
	// Initial boost
	if (up/*Jump Input*/) and (touching_ground/*currently touching the floor, or*/ or coyote_time > 0/*coyote time is active(4 frames)*/) {
		if (current_dash_speed > 15) {
			move_y = -jump_power / 2;
			current_dash_speed += jump_power / 3;
		} else if (current_dash_speed < -15) {
			move_y = -jump_power / 2;
			current_dash_speed += -jump_power / 3;
		} else {
			move_y = -jump_power;
		}
	}
	
	// Ground check
	if collision_rectangle(x - 32, y, x + 32, y + 4, obj_ground, false, true) {
		touching_ground = true;
		fall_speed_multiplier = 1;
		coyote_time = 4; // reset coyote time
		if (move_y > 0) {
			move_y = 0;
		}
	} else {
		touching_ground = false;
		if coyote_time > 0 { // tick down coyote time frames
			coyote_time -= 1;
		}
		
		// calculate fall speeds
			if (down and fall_speed_multiplier == 1) {move_y += 10;} // fast fall
			if (down) {fall_speed_multiplier = 2;} // fast fall
		
			move_y += 1 * fall_speed_multiplier; // apply fast fall multiplier
		
			if move_y > max_fall_speed { // fall speed cap
				move_y = max_fall_speed;
			}
	}
	
	//Ceiling Check
	if collision_rectangle(x - 32, y - 64, x + 32, y - 66, obj_ground, false, true) and (move_y < 0) {
		move_y = 0;
	}
	
	
// Move and Collide
	move_and_collide(move_x, move_y, obj_ground);