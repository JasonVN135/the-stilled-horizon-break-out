class_name HealthComponent
extends Node2D

@export var MAX_HEALTH : float 
@export var health : float

signal death

func _ready():
	health = MAX_HEALTH

func on_hit(damage : float) -> void:
	health -= damage
	# Ensure health does not go over MAX HEALTH
	health = min(health, MAX_HEALTH)
	if (health <= 0):
		death.emit()
