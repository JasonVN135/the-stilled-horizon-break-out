class_name Wing
extends CharacterBody2D

## The amount of force to apply on a physics body (Ball)
@export var push_force : float
## Boolean to determine if the wing is left or right to apply correct rotations
@export var is_left_wing : bool
var up_rotation : float
var down_rotation : float

## The max rotation in degrees of the left wing when it is down
const left_down_rotation : float = -35
## THe max rotation in degrees of the right wing when it is down
const right_down_rotation : float = 35
## The max rotation in degrees of the left wing when it is up
const left_up_rotation : float = 35
## The max rotation in degrees of the right wing when it is up
const right_up_rotation : float = -35
## The speed at which the wing flaps up
const flap_speed : float = 500


func start():

	if is_left_wing:
		scale.x = -1
		rotation_degrees = left_down_rotation
		down_rotation = left_down_rotation
		up_rotation = left_up_rotation
	else:
		scale.x = 1
		rotation_degrees = right_down_rotation
		down_rotation = right_down_rotation
		up_rotation = right_up_rotation
		
func _process(delta : float):
	# Handle Left Wing
	if is_left_wing:
		if Input.is_action_pressed("FlapLeft"):
			rotation_degrees = move_toward(rotation_degrees, up_rotation, delta * flap_speed)
		else:
			rotation_degrees = move_toward(rotation_degrees, down_rotation, delta * flap_speed)
		
	# Handle Right Wing
	else:
		if Input.is_action_pressed("FlapRight"):
			rotation_degrees = move_toward(rotation_degrees, up_rotation, delta * flap_speed)
		else:
			rotation_degrees = move_toward(rotation_degrees, down_rotation, delta * flap_speed)
			
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		

		
	
		
