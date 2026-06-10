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
	dash = keyboard_check(vk_shift);
	dash_p = keyboard_check_pressed(vk_shift);
	dash_r = keyboard_check_released(vk_shift);
	pickup = keyboard_check(ord("Z"));
	pickup_p = keyboard_check_pressed(ord("Z"));
	pickup_r = keyboard_check_released(ord("Z"));
	
// Horizontal Movement

	/* DASHROLLING, might use on a charcater but scrapped for now
	if (dash_p) and (horizontal_state == horizstate_normal) { 
		horizontal_state = horizstate_dashroll;
		current_move_speed += 7*dir;
		current_jump_force -= 7
	}
	if (dash_r) and (horizontal_state == horizstate_dashroll) {
		horizontal_state = horizstate_noinput;
		if (touching_ground) {
			dashroll_endlag = 20;
		} else {
			dashroll_endlag = 2;
		}
	}
	if (dashroll_endlag > 0) {
		dashroll_endlag -= 1;
		if (dashroll_endlag == 1) {
			horizontal_state = horizstate_normal;
		}
	}
	*/
	
	horizontal_state(); // the chunk of code that runs horizontal movement. see create event for definitions

	// Right Wall Collision
	if (collision_rectangle(x+16, y, x+17, y-32, collidable_objs, false, true)) {
		touching_right_wall = true;
		if move_x > 0 {
			move_x = 0; // halt momentum when hitting wall
			touched_right_wall = true;
			current_dash_speed_x = 0; // halt momentum of dash
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
			current_dash_speed_x = 0; // halt momentum of dash
		} else {
			touched_left_wall = false;
		}
		if current_move_speed < 0 {
			current_move_speed = 0;  // halt player horzontal movement
		}
	} else {
		touching_left_wall = false;
	}

	move_x = current_move_speed + current_dash_speed_x; // horizontal movement calculation
	
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
		dash_ready = true; // refresh dash
		current_fall_speed_multiplier = 1;
		coyote_time = 6; // reset coyote time
		if (current_jump_force > 0) {current_jump_force = 0;}
		if !collision_rectangle(x - 16, y, x + 16, y + 1, collidable_objs, false, true) { // make the character flush with the ground
			y += 1; // inch player to be flush with the ground
		}
	} else {
		touching_ground = false; // ...else we are not on the ground, so false
		if coyote_time > 0 {coyote_time -= 1;}  // tick down coyote time frames
		
		// calculate fall speeds
			if (down and current_fall_speed_multiplier == 1) { // fast fall
				current_fall_speed_multiplier = fall_speed_multiplier; // .. and falling faster
			}
		
			current_jump_force += player_gravity * current_fall_speed_multiplier; // apply fast fall multiplier
		
			if current_jump_force > max_fall_speed { // fall speed cap
				current_jump_force = max_fall_speed;
			}
	}
	
	//Ceiling Check
	if collision_rectangle(x - 16, y - 32, x + 16, y - 34, collidable_objs, false, true) and (current_jump_force < 0) {
		current_jump_force = 0;
		current_dash_speed_y = 0;
	}
	
	move_y = current_jump_force + current_dash_speed_y; // vertical movement calculation

// Move and Collide
	move_and_collide(move_x, move_y, collidable_objs);
	
// Pickup things
// TO-DO
// - buffer
// - Throw forward
// - throw up
// - throw down
	if (pickup_p) and (throw_cooldown == 0) {
		var _list = ds_list_create();
		// Pickup up
		if (up) and collision_rectangle_list(x - 4, y - 28, x + 4, y - 48, obj_grabbableblock, true, true, _list, false) {
			PickupObject(_list);
		} else if (up) and collision_rectangle_list(x - 14, y - 28, x + 14, y - 48, obj_grabbableblock, true, true, _list, false) {
			PickupObject(_list);
		// Pickup to the side
		} else if ((left) or (right)) and collision_rectangle_list(x + (24*dir), y - 8, x + (48*dir), y - 24, obj_grabbableblock, true, true, _list, false) {
			PickupObject(_list);
		// Pickup Beneath Player
		} else if collision_rectangle_list(x - 4, y + 12, x + 4, y + 20, obj_grabbableblock, true, true, _list, false) {
			PickupObject(_list);
		} else if collision_rectangle_list(x - 14, y + 12, x + 14, y + 20, obj_grabbableblock, true, true, _list, false) {
			PickupObject(_list);
		} else if collision_circle_list(x, y - 16, 32, obj_grabbableblock, true, true, _list, false) {
			PickupObject(_list);
		}
		ds_list_destroy(_list);
	}
	
	if (holding_obj) and not (throwing_obj) {
		held_obj_x_target = x - 16; // prep objects x
		held_obj_y_target = y - 48 - 16; // prep objects y
		held_obj.x = lerp(held_obj.x, held_obj_x_target, held_obj_interp); // lock objects x
		held_obj.y = lerp(held_obj.y, held_obj_y_target, held_obj_interp); // lock objects y
		held_obj.dir = dir; // set dir to player dir for throwing
		held_obj.state = 1; // set obj state to 1(held)
		if (held_obj_interp < 1) {held_obj_interp += 0.05;}
	}
	
	if (holding_obj) and !(pickup) and (held_obj_interp == 1) and (throwing_obj == false) {
		throwing_obj = true;
		held_obj_interp = 0.5;
		// Deciding what way to throw it
		if (up) {
			if (left) or (right) {
				thrown_obj_dir = "upforward";
			} else {
				thrown_obj_dir = "up";
			}
		} else if (left) or (right) {
			thrown_obj_dir = "forward";
		} else if (down) {
			thrown_obj_dir = "down";
		} else {
			thrown_obj_dir = "upforward";
		}
	}
	
	if (throwing_obj) {
		held_obj.dir = dir;
		held_obj.state = 1;
		// Deciding what way to throw it
		switch thrown_obj_dir
		{
			case "upforward":
				held_obj_x_target = x - 16; // prep objects x
				held_obj_y_target = y - 48 - 16; // prep objects y
			break;
			case "forward":
				held_obj_x_target = x - 16 + (32*dir); // prep objects x
				held_obj_y_target = y - 32; // prep objects y
			break;
			case "up":
				held_obj_x_target = x - 16; // prep objects x
				held_obj_y_target = y - 48 - 16; // prep objects y
				held_obj.airtime = 30;
			break;
			case "down":
				held_obj_x_target = x - 16; // prep objects x
				held_obj_y_target = y; // prep objects y
				held_obj.airtime = 30;
			break;
		}
		held_obj.x = lerp(held_obj.x, held_obj_x_target, held_obj_interp); // lock objects x
		held_obj.y = lerp(held_obj.y, held_obj_y_target, held_obj_interp); // lock objects y
		if (held_obj_interp < 1) {held_obj_interp += 0.1;}
		if (held_obj_interp == 1) {
			audio_play_sound(snd_smb2_throw, 3, false, 1, 0, 1); // sfx
			held_obj.state = 2; // set obj state to 2(thrown)
			held_obj.throwspeed += abs(move_x*0.75); // conservation of momentum
			if thrown_obj_dir == "up" {
				held_obj.throwspeed = 0;
				held_obj._gravity -= 10;
				held_obj._gravity += move_y*0.75;
			} else if thrown_obj_dir == "down" {
				held_obj.throwspeed = 0;
				held_obj._gravity += 10;
				held_obj._gravity += move_y*0.75;
			}
			held_obj = noone; // reset held object
			holding_obj = false; // not holding an object anymore
			throw_cooldown = 20;
			throwing_obj = false;
		}
	}
	
	if (throw_cooldown > 0) {throw_cooldown -= 1;}
	
// State Machine
	main_index += 0.5;
	if (horizontal_state == horizstate_dashroll) {
		animation_state = "dashroll";
		main_sprite = spr_test_roll;
	} else if !(touching_ground) {
		if (move_y < 0) {
			animation_state = "ascending";
			main_sprite = spr_test_jump;
		} else {
			animation_state = "decending";
			main_sprite = spr_test_fall;
		}
	} else {
		if (right - left) == 0 {
			animation_state = "idle";
			main_sprite = spr_test_idle;
		} else {
			animation_state = "walking";
			main_sprite = spr_test_idle;
		}
	}