extends ProgressBar

@onready var health_component : HealthComponent = $"../HealthComponent"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	max_value = health_component.MAX_HEALTH
	value = max_value
	

func _process(delta: float) -> void:
	value = health_component.health
	if value != max_value:
		visible = true
	
