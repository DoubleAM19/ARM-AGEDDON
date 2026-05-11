/// @description runs apon object creation

// Variables
	//REAL
	move_x = 0;
	move_y = 0;
	
	jump_power = 17;
	move_speed = 10;
	current_move_speed = 0;
	
	fire_delay = 20;
	fire_delay_current = 30;
	bullet_lifespan = 30;
	every_10_shots_fired = 0;
	
	maxhp = 6;
	normalhp = 3;
	totalhp = normalhp + 0/*other hp types when added*/;
	totalhpmirror = totalhp;
	hp_change = 0; // -1 for negative change(health loss), 1 for positive change(health gain)
	
	//BOOL
	touching_ground = false;
	bullet_shot = false;
	touching_right_wall = false;
	touching_left_wall = false;
	touched_right_wall = false;
	touched_left_wall = false;
	_10_shots_fired = false;
	
	//STRING
	state = "idle"
	
	//CONTROLS
	up = keyboard_check(ord("W"));
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
	m1 = mouse_check_button(1);
	
window_set_cursor(cr_none);

cursor_sprite = spr_crosshair;