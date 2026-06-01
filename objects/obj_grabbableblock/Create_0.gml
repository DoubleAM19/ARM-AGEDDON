// Variables
	dir = 0;
	state = 0; // 0 = placed, 1 = held, 2 = thrown
	ground_tile = instance_create_layer(x, y, "ActiveGround", obj_ground); // ground tile associated with this block