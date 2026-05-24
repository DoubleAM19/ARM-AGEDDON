 /// @description runs every frame

// Horizontal Movement
	// Right Wall Collision
	if (collision_rectangle(x+16, y, x+18, y-16, obj_ground, false, true)) {
		touching_right_wall = true;
		if move_x > 0 {
			move_x = 0;
			touched_right_wall = true;
		} else {
			touched_right_wall = false;
		}
	} else {
		touching_right_wall = false;
	}
	// Left Wall Collision
	if (collision_rectangle(x-16, y, x-18, y-16, obj_ground, false, true)) {
		touching_left_wall = true;
		if move_x < 0 {
			move_x = 0;
			touched_left_wall = true;
		} else {
			touched_left_wall = false;
		}
	} else {
		touching_left_wall = false;
	}
	
	// Ground check
	if collision_rectangle(x - 16, y, x + 16, y + 4, obj_ground, false, true) {
		if (move_y > 0) {move_y = 0;}
	} else {
		move_y += object_gravity;
	}
	
	//Ceiling Check
	if collision_rectangle(x - 16, y - 32, x + 16, y - 34, obj_ground, false, true) and (move_y < 0) {
		move_y = 0;
	}
	
// Move and Collide
	move_and_collide(move_x, move_y, obj_ground);