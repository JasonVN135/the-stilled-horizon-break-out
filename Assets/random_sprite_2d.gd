extends Sprite2D

var frames = 0

func _ready():
	frames = texture.get_width() / region_rect.size.x
	var random_index = randi_range(0, frames - 1)
	region_rect.position.x = random_index * region_rect.size.x
