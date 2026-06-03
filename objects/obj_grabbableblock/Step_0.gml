if !(state == 0) {
	instance_destroy(ground_tile);
}

if (state == 1) {
	_gravity = 0;
}


if (state == 2) {
	if (airtime > 30) { // make block fall after half a sec
		_gravity += 0.5;
	}
	
	if collision_rectangle(x + 4, y + 4, x + 28, y + 28, obj_ground, false, true) { // check collision with ground
		instance_destroy();
	}
	airtime += 1;
	x += throwspeed * dir;
	y += _gravity;
}
