extends PowerUpComponent

@onready var blast_radius : Area2D = $BlastRadius

func activate():
	for child in blast_radius.get_overlapping_bodies():
		if child is Motorcycle:
			child.hit(Vector2(0, -1))
	queue_free()
