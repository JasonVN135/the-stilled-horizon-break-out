extends Control


func _on_play_button_pressed() -> void:
	Globals.game_score = 0
	Globals.game_multiplier = 1
	TransitionScreen.transition_to_black()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://World/game_scene.tscn")


func _on_story_button_pressed() -> void:
	TransitionScreen.transition_to_black()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://World/game_scene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
