class_name Motorcycle
extends CharacterBody2D

@export var points : float = 100

enum State {CHASE, DESTROY}


var x_dir : float = 0
var y_acceleration: float = 5.0
var y_recovery: float = 750.0
var x_acceleration: float = 500.0
var max_speed: float = 40.0
var hit_speed: float = 300.0
var is_hit: bool = false

@onready var health_component : HealthComponent = $HealthComponent

func _ready():
	x_acceleration = randf_range(25, 100)
	health_component.connect("death", _on_death)

func _physics_process(delta: float) -> void:
	if velocity.y < 0:
		velocity.y = move_toward(velocity.y, max_speed, y_recovery * delta)
	else:
		velocity.y = move_toward(velocity.y, max_speed, y_acceleration * delta)
	
	x_dir += delta
	
	velocity.x = (sin(x_dir) * x_acceleration)
	
	move_and_slide()


func hit(direction: Vector2):
	if direction.x < 0:
		velocity.x = hit_speed
	else:
		velocity.x = -hit_speed
	velocity.y = -hit_speed
	health_component.on_hit(1)
	
func _on_death():
	
	Globals.game_score += floor(points * Globals.game_multiplier)
	Globals.game_multiplier += .5
	Globals.powerup_counter += 1
	Globals.powerup_counter = min(Globals.MAX_POWERUP_CHARGE, Globals.powerup_counter)
	queue_free()
