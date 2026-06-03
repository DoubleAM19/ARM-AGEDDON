// Variables
	dir = 0; // *direction
	state = 0; // 0 = placed, 1 = held, 2 = thrown
	airtime = 0; // counts how many frames the block has been airborn for
	throwspeed = 10; // how fast in pixels the block flies
	_gravity = 0; // .. its how fast it falls its gravity :P
	
	ground_tile = instance_create_layer(x, y, "ActiveGround", obj_ground); // ground tile associated with this block