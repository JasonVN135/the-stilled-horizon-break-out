class_name PowerUpManager
extends Node2D

enum POWERUP {BOMB, SPLIT}

var current_powerup = POWERUP.BOMB

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select_random_powerup()

func select_random_powerup() -> POWERUP:
	current_powerup = POWERUP.values().pick_random()
	return current_powerup

func get_current_powerup() -> POWERUP:
	return current_powerup
