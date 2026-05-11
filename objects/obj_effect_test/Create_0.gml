/// @description ran when object created

// Variables
randomise();

// set trigger and triggered effects
rand = 3;
rand2 = 1;

trigger = noone;
trigger_text = "";
triggered_effect = noone;
triggered_effect_text = "";
full_effect_text = "";

// Functions
	// Trigger
	function Trigger_EveryJump() { // Every time you jump,
		if (obj_player_old.up) and (obj_player_old.touching_ground) {
			return true;
		} else {
			return false;
		}
	}

	function Trigger_Every10Shots() { // Every 10 shots
		if (obj_player_old._10_shots_fired) {
			return true;
		} else {
			return false;
		}
	}

	function Trigger_EveryWallHit() { // Every time you hit a wall,
		if (obj_player_old.touched_left_wall) or (obj_player_old.touched_right_wall) {
			return true;
		} else {
			return false;
		}
	}

	function Trigger_EveryHPGain() { // Every time you gain health,
		if (obj_player_old.hp_change == 1) {
			return true;
		} else {
			return false;
		}
	}

	// Instant
	function Instant_StatIncrease(stat, amount) { // Doesn't work??
		stat += amount;
	}

	function TriggeredEffects_GoDown() {
		y += 20;
	}

	function TriggeredEffects_GoLeft() {
		x -= 20;
	}