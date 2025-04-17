extends Control


func _on_return_button_pressed() -> void:
	TransitionScreen.transition_to_black()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
