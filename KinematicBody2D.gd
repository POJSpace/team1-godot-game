extends KinematicBody2D

export var speed = 200
export var jump_power_min = 200
export var jump_power_max = 900
export var gravity = 1200
export var acc = 5

var motion = Vector2.ZERO
var is_jumping = false
var jump_power = jump_power_min

func _physics_process(delta):
	motion.y += gravity * delta
	if Input.is_action_pressed("right"):
		motion.x = min(motion.x + acc, speed)
	elif Input.is_action_pressed("left"):
		motion.x = max(motion.x - acc, -speed)
	else:
		motion.x = 0

	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true

	if is_jumping and Input.is_action_pressed("jump") and jump_power < jump_power_max:
		jump_power += delta * 500

	if is_jumping and Input.is_action_just_released("jump"):
		motion.y = -jump_power
		is_jumping = false
		jump_power = jump_power_min

	motion = move_and_slide(motion, Vector2.UP)
