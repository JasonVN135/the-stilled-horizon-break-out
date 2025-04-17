extends PowerUpComponent


@onready var ball = preload("res://Characters/ball.tscn")

func activate():
	var instance : Ball = ball.instantiate()
	instance.scale = Vector2(0.4, 0.4)
	instance.modulate = Color(0, .8, 1, 1)
	# Get direction to center of the screen
	var offset_dir = Vector2(0, 0) - position
	offset_dir *= 60
	

	instance.global_position = Vector2(960, 500)
	instance.freeze = false
	instance.shoot(0.1)
	instance.state = Ball.BALL_STATE.BOUNCE
	
	get_tree().root.add_child(instance)
	queue_free()
