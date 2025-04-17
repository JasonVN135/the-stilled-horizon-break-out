extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer

signal start_game

func _ready():
	show()
	
func resume():
	animation_player.play_backwards("blur")
	hide()

func _on_play_pressed() -> void:
	start_game.emit()
	resume()
	
