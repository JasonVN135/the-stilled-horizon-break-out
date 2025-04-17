class_name Game
extends Node2D

var ball_respawn_y = 332

var num_difficulty_increases : int = 0

@onready var bomb_powerup  = preload("res://Characters/Powerups/bomb_power_up.tscn")
@onready var split_powerup = preload("res://Characters/Powerups/split_power_up.tscn")

@onready var ui_canvas_layer = $UI
@onready var completion_bar : CompletionBar = $UI/CompletionBar
@onready var powerup_icon = $UI/PowerUpIcon

@onready var powerup_manager : PowerUpManager = $PowerUpManager
@onready var difficulty_timer = $DifficultyTimer
@onready var spawner : Spawner = $Spawner
@onready var tutorial_page : Control = $CanvasLayer/TutorialPage

@onready var ball : Ball = $Ball
@onready var truck : Truck = $Truck


func _ready():
	# Quickly spawn the fist enemy
	ui_canvas_layer.visible = false
	tutorial_page.connect("start_game", _start_game)
	difficulty_timer.wait_time = 2
	truck.ball = ball
	completion_bar.connect("game_complete", _on_game_complete)
	await TransitionScreen.on_to_normal_finished

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("PowerUp") and Globals.powerup_counter == Globals.MAX_POWERUP_CHARGE and !ball.has_powerup:
		var current_powerup : PowerUpManager.POWERUP = powerup_manager.get_current_powerup()
		if (current_powerup == PowerUpManager.POWERUP.BOMB):
			var instance : PowerUpComponent = bomb_powerup.instantiate() as PowerUpComponent
			ball.add_powerup(instance)
		elif (current_powerup == PowerUpManager.POWERUP.SPLIT):
			var instance : PowerUpComponent = split_powerup.instantiate() as PowerUpComponent
			ball.add_powerup(instance)
		var powerup = powerup_manager.select_random_powerup()
		powerup_icon.switch_powerup_icon(powerup)
		Globals.powerup_counter = 0

func _start_game():
	ui_canvas_layer.visible = true
	spawner.start()
	difficulty_timer.start()
	completion_bar.run = true
	var powerup = powerup_manager.select_random_powerup()
	powerup_icon.switch_powerup_icon(powerup)

func _on_difficulty_timer_timeout() -> void:
	## Increate the difficulty on the game
	## Spawner spawns enemies more frequently
	## Set the difficulty spawner to be a random time
	spawner.increase_spawnrate(randf_range(0, 0.3))
	difficulty_timer.wait_time = randi_range(25, 30)
	num_difficulty_increases += 1
	if num_difficulty_increases % 3 == 0:
		spawner.increase_spawn_number(1)


func _on_game_over_body_entered(body: Node2D) -> void:
	## A motorcycle has reached the player
	if body is Motorcycle:
		TransitionScreen.transition_to_black()
		await TransitionScreen.on_transition_finished
		var tree = TransitionScreen.get_tree()
		tree.change_scene_to_file("res://Menus/game_over_menu.tscn")


func _on_ball_despawn_body_entered(body: Node2D) -> void:
	# Check specifically it is the main ball
	if body == ball:
		ball.freeze = true
		ball.state = ball.BALL_STATE.IDLE
		ball.position = Vector2(truck.position.x, ball_respawn_y)
		
func _on_game_complete():
	TransitionScreen.transition_to_black()
	await TransitionScreen.on_transition_finished
	var tree = TransitionScreen.get_tree()
	tree.change_scene_to_file("res://Menus/game_complete_menu.tscn")
