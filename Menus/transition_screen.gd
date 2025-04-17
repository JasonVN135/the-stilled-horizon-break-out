extends CanvasLayer

@onready var color_rect : ColorRect = $ColorRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer

signal on_transition_finished
signal on_to_normal_finished

func _ready():
	color_rect.visible = false
	
	
func transition_to_black():
	color_rect.visible = true
	animation_player.play("fade_to_black")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
		on_to_normal_finished.emit()
