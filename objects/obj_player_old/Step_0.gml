/// @description runs every frame

//CONTROLS
	up = keyboard_check(ord("W"));
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
	m1 = mouse_check_button(1);

// Horizontal Movement
	move_x = current_move_speed;
	// Speed up
	current_move_speed += (right - left) * 2;
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
	if (collision_rectangle(x+32, y, x+33, y-64, obj_ground, false, true)) {
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
	if (collision_rectangle(x-32, y, x-33, y-64, obj_ground, false, true)) {
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
	if (up) and (touching_ground) {
		move_y = -jump_power;
	}
	
	// Ground check
	if collision_rectangle(x - 32, y, x + 32, y + 2, obj_ground, false, true) {
		touching_ground = true;
		if (move_y > 0) {
			move_y = 0;
		}
	} else {
		touching_ground = false;
		move_y += 1;
		if move_y > 20 {
			move_y = 20;
		}
	}
	
	//Ceiling Check
	if collision_rectangle(x - 32, y - 64, x + 32, y - 66, obj_ground, false, true) and (move_y < 0) {
		move_y = 0;
	}
	
	
// Move and Collide
	move_and_collide(move_x, move_y, obj_ground);
	
// Shooting
	_10_shots_fired = false;
	if (m1) { // Mouse1 pressed
		if (fire_delay_current = 0) { // Weapon ready to be fired?
			last_bullet = instance_create_layer(x, y-32, "Active", obj_bullet); // set instance to var for later
			last_bullet.lifespan = bullet_lifespan; // this is the later
			fire_delay_current = fire_delay; // reset delay...
			every_10_shots_fired += 1; // shot counter
			if every_10_shots_fired == 10 { 
				every_10_shots_fired = 0;
				_10_shots_fired = true;
			}
		}
	}
	
	if (fire_delay_current > 0) {
		fire_delay_current -= 1; // countdown the fire delay
	}
	
// Health
	totalhp = normalhp; // all hp forms added up
	if !(totalhpmirror == totalhp) { // check if any change to hp has been made
		if totalhpmirror > totalhp {
			hp_change = -1;
		}
		if totalhpmirror < totalhp {
			hp_change = 1;
		}
		totalhpmirror = totalhp;
	} else {
		hp_change = 0;
	}
	
	if keyboard_check_pressed(vk_left) {
		normalhp += 1;
	}