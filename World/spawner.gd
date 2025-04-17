class_name Spawner
extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var motorcycle = preload("res://Characters/motorcycle.tscn")

var spawn_count : int = 1


func start():
	spawn_enemy()
	spawn_timer.start()

func increase_spawnrate(modify : float):
	spawn_timer.wait_time -= modify
	
func increase_spawn_number(increment : int):
	spawn_count += 1

func _on_spawn_timer_timeout() -> void:
	## Spawn a random number of enemies between 1 and spawn_count
	for i in range(spawn_count):
		spawn_enemy()
	spawn_timer.start()

func spawn_enemy():
	var x_spawn_loc : int = randi_range(Globals.X_LEFT_BOUND, Globals.X_RIGHT_BOUND)
	var instance : Motorcycle = motorcycle.instantiate()
	self.add_child(instance)
	instance.position = Vector2(x_spawn_loc, 0)
