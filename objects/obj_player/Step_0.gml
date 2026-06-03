 /// @description runs every frame

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
	
// Horizontal Movement

	if (dashroll) { // placeholder code
		horizontal_state = horizstate_dashroll;
	} else {
		horizontal_state = horizstate_normal;
	}
	
	horizontal_state(); // the chunk of code that runs horizontal movement. see create event for definitions
	
	if horizontal_state == horizstate_dashroll {_image_angle = -x*2;} // placeholder code
	
	// Right Wall Collision
	if (collision_rectangle(x+16, y, x+17, y-32, collidable_objs, false, true)) {
		touching_right_wall = true;
		if move_x > 0 {
			move_x = 0; // halt momentum when hitting wall
			touched_right_wall = true;
		} else {
			touched_right_wall = false;
		}
		if current_move_speed > 0 { // halt player horzontal movement
			current_move_speed = 0;
		}
	} else {
		touching_right_wall = false;
	}
	// Left Wall Collision
	if (collision_rectangle(x-16, y, x-17, y-32, collidable_objs, false, true)) {
		touching_left_wall = true;
		if move_x < 0 {
			move_x = 0; // halt momentum when hitting wall
			touched_left_wall = true;
		} else {
			touched_left_wall = false;
		}
		if current_move_speed < 0 {
			current_move_speed = 0;  // halt player horzontal movement
		}
	} else {
		touching_left_wall = false;
	}

	move_x = current_move_speed; // horizontal movement calculation
	
// Jumping
	// Buffered input
	if (jump_p) {jump_input_buffer = 8;}
	if (jump_input_buffer > 0) {jump_input_buffer -= 1;}
	// Initial boost
	if (jump_p/*Jump Input*/ or jump_input_buffer/*buffered jump input*/) and (touching_ground/*currently touching the floor, or*/ or coyote_time > 0/*coyote time is active(4 frames)*/) {
		current_jump_force = -jump_power; // else normal jump
		audio_play_sound(snd_playerjump, 3, false, 1, 0, random_range(0.9, 1.1)); // sfx
		coyote_time = 0; // reset coyote time
	}
	// Added height from holding jump
	if !(touching_ground) and (jump) and (current_jump_force < 0) { // not on ground, jump button held, and currently ascending
		current_jump_force -= 0.5;
	}
	
	// Ground check
	if collision_rectangle(x - 16, y, x + 16, y + 4, collidable_objs, false, true) {
		touching_ground = true; // we are currently on the ground, so set this to true
		fall_speed_multiplier = 1;
		coyote_time = 6; // reset coyote time
		if (current_jump_force > 0) {current_jump_force = 0;}
		if !collision_rectangle(x - 16, y, x + 16, y + 1, collidable_objs, false, true) { // make the character flush with the ground
			y += 1; // inch player to be flush with the ground
		}
	} else {
		touching_ground = false; // ...else we are not on the ground, so false
		if coyote_time > 0 {coyote_time -= 1;}  // tick down coyote time frames
		
		// calculate fall speeds
			if (down and fall_speed_multiplier == 1) { // fast fall
				current_jump_force += 10; // burst of speed
				audio_play_sound(snd_fastfall, 3, false, 1, 0, random_range(0.9, 1.1)); // sfx
				fall_speed_multiplier = 2; // .. and falling faster
			}
		
			current_jump_force += player_gravity * fall_speed_multiplier; // apply fast fall multiplier
		
			if current_jump_force > max_fall_speed { // fall speed cap
				current_jump_force = max_fall_speed;
			}
	}
	
	//Ceiling Check
	if collision_rectangle(x - 16, y - 32, x + 16, y - 34, collidable_objs, false, true) and (current_jump_force < 0) {
		current_jump_force = 0;
	}
	
	move_y = current_jump_force; // vertical movement calculation

// Move and Collide
	move_and_collide(move_x, move_y, collidable_objs);
	
// Pickup things
	if (pickup_p) and (throw_cooldown == 0) {
		var _list = ds_list_create(); 
		if collision_rectangle_list(x - 4, y + 12, x + 4, y + 20, obj_grabbableblock, true, true, _list, false) {
			held_obj = _list[| 0];
			holding_obj = true;
			held_obj.placed = false;
			held_obj_interp = 0.1;
			audio_play_sound(snd_smb2_pickup, 3, false, 1, 0, 1); // sfx
			current_jump_force -= 5;
		} else if collision_rectangle_list(x - 14, y + 12, x + 14, y + 20, obj_grabbableblock, true, true, _list, false) {
			held_obj = _list[| 0];
			holding_obj = true;
			held_obj.placed = false;
			held_obj_interp = 0.1;
			audio_play_sound(snd_smb2_pickup, 3, false, 1, 0, 1); // sfx
			current_jump_force -= 5;
		}
		ds_list_destroy(_list);
	}
	if (holding_obj) and (pickup) {
		held_obj_x_target = x - 16; // prep objects x
		held_obj_y_target = y - 48 - 16; // prep objects y
		held_obj.x = lerp(held_obj.x, held_obj_x_target, held_obj_interp); // lock objects x
		held_obj.y = lerp(held_obj.y, held_obj_y_target, held_obj_interp); // lock objects y
		held_obj.dir = dir; // set dir to player dir for throwing
		held_obj.state = 1; // set obj state to 1(held)
		if (held_obj_interp < 1) {held_obj_interp += 0.05;}
	}
	if (holding_obj) and (pickup_r) {
		audio_play_sound(snd_smb2_throw, 3, false, 1, 0, 1); // sfx
		held_obj.state = 2; // set obj state to 2(thrown)
		held_obj.throwspeed += abs(move_x*0.75); // conservation of momentum
		held_obj = noone; // reset held object
		holding_obj = false; // not holding an object anymore
		throw_cooldown = 20;
	}
	
	if (throw_cooldown > 0) {throw_cooldown -= 1;}