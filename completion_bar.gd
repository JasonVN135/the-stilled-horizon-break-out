class_name CompletionBar
extends Node2D

signal game_complete

@onready var progress_bar_sprite : Sprite2D = $Sprite2D
@onready var indicator : Node2D = $Indicator

## Take it takes to complete the game
var completion_time : float = 240
## Time so far
var elapsed_time : float = 0

var start_position : float = 0
var bar_width : float = 0
var offset_sprite : float = 250

@export var run : bool = false

func _ready() -> void:
	bar_width = progress_bar_sprite.texture.get_width() - offset_sprite
	start_position = bar_width / -2
	#Set the indicator's position to be on the left side
	indicator.position.x = start_position + offset_sprite
	
func _process(_delta: float) -> void:
	
	if run and elapsed_time >= completion_time:
		# Send a signal to say the game is complete
		game_complete.emit()
	elapsed_time += _delta
	# Se tthe indicator position
	indicator.position.x = min((elapsed_time / completion_time) * bar_width + start_position, start_position * -1)
	
