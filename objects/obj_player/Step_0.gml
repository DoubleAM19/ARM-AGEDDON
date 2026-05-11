/// @description runs every frame

//CONTROLS
	up = keyboard_check(ord("W"));
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
	dash = keyboard_check(vk_shift);
	m1 = mouse_check_button(1);

// Horizontal Movement
	move_x = current_move_speed + current_dash_speed; // horizontal movement calculation

	current_move_speed += (right - left) * 2; // add moving left and right influence
	
	
	
	// Dashing
	if (dash) {
		if (left and right) {
			if (move_x < 0) {
				current_dash_speed = -20;
			} else {
				current_dash_speed = 20;
			}
		} else {
			if (left) {
				current_dash_speed = -20;
			} else if (right) {
				current_dash_speed = 20;
			} else {
				if (dir == -1) {
					current_dash_speed = -20;
				}
				if (dir == 1) {
					current_dash_speed = 20;
				}	
			}
		}
	}
	
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
		move_y = -jump_power;
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