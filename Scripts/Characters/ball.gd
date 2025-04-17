class_name Ball
extends RigidBody2D

enum BALL_STATE {RESPAWN, IDLE, BOUNCE}

var state : BALL_STATE = BALL_STATE.IDLE
var has_powerup : bool = false
@export var up_force : float = 1000.0

@export var base_texture : Texture
@onready var sprite : Sprite2D = $Sprite2D
@onready var enemy_hit_sound: AudioStreamPlayer2D = $EnemyHitSound
@onready var collision_sound: AudioStreamPlayer2D = $CollisionSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(_delta : float) -> void:
	if state == BALL_STATE.IDLE:
		linear_velocity = Vector2(0, 0)
		freeze = true

func shoot(power : float) -> void:
	## Shoot the ball upwards whenever it is in the idle state
	if state == BALL_STATE.IDLE:
		freeze = false
		state = BALL_STATE.BOUNCE
		apply_impulse(Vector2(randf_range(-1, 1) * 50, -power * up_force), Vector2(0, 32))

func _on_body_entered(body: Node) -> void:
	if state == BALL_STATE.BOUNCE:
		var pitch_adjust = remap(linear_velocity.length(), 0, 1500, 1.5, 0.5)
		collision_sound.pitch_scale = pitch_adjust
		collision_sound.play()
	
	if body is Motorcycle and state == BALL_STATE.BOUNCE:
		enemy_hit_sound.play()
		body = body as Motorcycle
		body.hit(linear_velocity)
		for child in get_children():
			if child is PowerUpComponent:
				child.activate()
				sprite.texture = base_texture
				break
	# Reset multiplier
	elif body is Truck or body is Wing:
		Globals.game_multiplier = 1.0

func add_powerup(powerup : PowerUpComponent):
	add_child(powerup)
	if powerup.ball_texture != null:
		sprite.texture = powerup.ball_texture
