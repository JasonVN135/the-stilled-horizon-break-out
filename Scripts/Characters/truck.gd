class_name Truck
extends CharacterBody2D

#@export var ball : Ball

var init_y : float
var plunger_charge : float
const SPEED = 600.0

@onready var left_wing = $LeftWing
@onready var right_wing = $RightWing
@onready var charge_sound: AudioStreamPlayer2D = $ChargeSound
@onready var shoot_sound: AudioStreamPlayer2D = $ShootSound
@onready var ball: Ball = $"../Ball"

func _ready() -> void:
	left_wing.position = Vector2(0, -48)
	right_wing.position = Vector2(0, -48)
	left_wing.start()
	right_wing.start()
	init_y = global_position.y

func _physics_process(_delta: float) -> void:
	
	# Have ball's position align with truck if at idle
	if (ball != null && ball.state == ball.BALL_STATE.IDLE):
		ball.global_position.x = self.global_position.x

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if global_position.y != init_y:
		global_position.y = move_toward(global_position.y, init_y, SPEED)

	# Release plunger
	if Input.is_action_just_released("Shoot") and ball.state == ball.BALL_STATE.IDLE:
		ball.shoot(plunger_charge)
		plunger_charge = 0
		charge_sound.stop()
		charge_sound.seek(0.0)
		shoot_sound.play()
		
	# List to charge up of the plunger
	elif Input.is_action_pressed("Shoot") and ball.state == ball.BALL_STATE.IDLE:
		plunger_charge += _delta
		plunger_charge = min(plunger_charge, 1)
		if (!charge_sound.playing):
			charge_sound.play()

	move_and_slide()
