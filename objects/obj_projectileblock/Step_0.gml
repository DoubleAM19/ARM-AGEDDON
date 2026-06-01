 /// @description runs every frame

// Horizontal Movement
	// Right Wall Collision
	if (collision_rectangle(x+16, y, x+18, y-16, obj_ground, false, true)) {
		touching_right_wall = true;
		if move_x > 0 {
			move_x = 0;
			external_force_x = 0;
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
			external_force_x = 0;
			touched_left_wall = true;
		} else {
			touched_left_wall = false;
		}
	} else {
		touching_left_wall = false;
	}
	
	// Ground check
	if collision_rectangle(x - 16, y, x + 16, y + 4, obj_ground, false, true) {
		if (obj_gravity_current > 0) {obj_gravity_current = 0;}
		touching_floor = true;
	} else {
		obj_gravity_current += object_gravity;
		touching_floor = false;
	}
	
	//Ceiling Check
	if collision_rectangle(x - 16, y - 32, x + 16, y - 34, obj_ground, false, true) and (obj_gravity_current < 0) {
		obj_gravity_current = 0;
	}
	
	if grab_suction_x > 0 {grab_suction_x -= 1;} // tick down grab suction
	if grab_suction_x < 0 {grab_suction_x += 1;}
	if grab_suction_y > 0 {grab_suction_y -= 1;}
	if grab_suction_y < 0 {grab_suction_y += 1;}
	if (-1 < grab_suction_x and grab_suction_x < 1) {grab_suction_x = 0;} // prevent number resting at a decimal less than 1 but bigger than 0
	if (-1 < grab_suction_y and grab_suction_y < 1) {grab_suction_y = 0;}
	if grab_suction_x > grab_suction_cap {grab_suction_x = grab_suction_cap;} // Speed caps
	if grab_suction_x < -grab_suction_cap {grab_suction_x = -grab_suction_cap;}
	if grab_suction_y > grab_suction_cap {grab_suction_y = grab_suction_cap;}
	if grab_suction_y < -grab_suction_cap {grab_suction_y = -grab_suction_cap;}
	
	if external_force_x > 0 {external_force_x -= 0.4;} // tick down external force (x)
	if external_force_x < 0 {external_force_x += 0.4;}
	if (external_force_x > 0) and (touching_floor) {external_force_x -= 0.6;} // tick down external force (x) more when on ground due to friction
	if (external_force_x < 0) and (touching_floor) {external_force_x += 0.6;}
	if external_force_y > 0 {external_force_y -= 0.5;}
	if external_force_y < 0 {external_force_y += 0.5;}
	if (-1 < external_force_x and external_force_x < 1) {external_force_x = 0;} // prevent number resting at a decimal less than 1 but bigger than 0
	if (-1 < external_force_y and external_force_y < 1) {external_force_y = 0;}
	
	move_x = grab_suction_x + external_force_x;
	move_y = obj_gravity_current + grab_suction_y + external_force_y;
	
// Move and Collide
	move_and_collide(move_x, move_y, obj_ground);