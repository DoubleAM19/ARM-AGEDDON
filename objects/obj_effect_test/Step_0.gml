/// @description runs all the time

switch rand // set trigger
{
// Triggers:
	case 0:
		trigger = Trigger_EveryJump();
		trigger_text = "Every time you jump, "
	break;
	
	case 1:
		trigger = Trigger_Every10Shots();
		trigger_text = "Every 10 shots fired, "
	break;
	
	case 2:
		trigger = Trigger_EveryWallHit();
		trigger_text = "Every time you hit a wall, "
	break;
	
	case 3:
		trigger = Trigger_EveryHPGain();
		trigger_text = "Every time you gain health, "
	break;
	
}

switch rand2 //SET TEXT FOR TRIGGERED EFFECT
{
// TRIGGERED EFFECTS
	case 0:
		triggered_effect_text = "go down."
	break;

	case 1:
		triggered_effect_text = "go down."
	break;

	case 2:
		triggered_effect_text = "go left."
	break;

}

if trigger { // TRIGGER THE TRIGGERED EFFECT
	switch rand2
	{
	// TRIGGERED EFFECTS
		case 0:
			TriggeredEffects_GoDown();
		break;
	
		case 1:
			TriggeredEffects_GoDown();
		break;
	
		case 2:
			TriggeredEffects_GoLeft();
		break;
	
	}
}

full_effect_text = trigger_text + triggered_effect_text;

if (keyboard_check_pressed(vk_down)) {
	rand = round(random_range(0, 2));
	rand2 = round(random_range(0, 2));
}