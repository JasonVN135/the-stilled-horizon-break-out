extends TextureRect

const bomb_icon : String = "res://Assets/Ball/Bomb.PNG"
const split_icon : String = "res://Assets/Ball/SplitBallIcon.PNG"

@onready var power_up_progress_bar : TextureProgressBar = $TextureProgressBar

func _process(delta: float) -> void:
	power_up_progress_bar.value = Globals.MAX_POWERUP_CHARGE - Globals.powerup_counter

func switch_powerup_icon(powerup : PowerUpManager.POWERUP):
	if (powerup == PowerUpManager.POWERUP.BOMB):
		texture = preload(bomb_icon)
	elif (powerup == PowerUpManager.POWERUP.SPLIT):
		texture = preload(split_icon)
	power_up_progress_bar.max_value = Globals.MAX_POWERUP_CHARGE
	power_up_progress_bar.min_value = 0
	power_up_progress_bar.value = Globals.MAX_POWERUP_CHARGE
