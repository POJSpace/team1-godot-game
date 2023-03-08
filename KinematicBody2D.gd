extends KinematicBody2D

export var speed = 200
export var jump_power_min = 200
export var jump_power_max = 900
export var gravity = 1200
export var acc = 100
export var deacc = 50

var motion = Vector2.ZERO
var is_jumping = false
var jump_power = jump_power_min

func _physics_process(delta):
	motion.y += gravity * delta
	if Input.is_action_pressed("right"):
		motion.x += acc * delta 
		if motion.x > speed:
			motion.x = speed
	elif Input.is_action_pressed("left"):
		motion.x -= acc * delta 
		if motion.x < -speed:
			motion.x = -speed
	if motion.x > 0:
		motion.x -= deacc * delta
	elif motion.x < 0:
		motion.x += deacc * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true

	if is_jumping and Input.is_action_pressed("jump") and jump_power < jump_power_max:
		jump_power += delta * 500
		motion.x = 0
	
	if is_jumping and Input.is_action_just_released("jump"):
		if Input.is_action_pressed("right"):
			motion.x += jump_power
		if Input.is_action_pressed("left"):
			motion.x -= jump_power
		motion.y = -jump_power
		is_jumping = false
		jump_power = jump_power_min
	

	motion = move_and_slide(motion, Vector2.UP)

