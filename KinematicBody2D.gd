extends KinematicBody2D

export var speed = 150
export var jump_power_min = 200
export var jump_power_max = 650
export var gravity = 1100
export var acc = 300
export var deacc = 1300 #akcelerace zastavení
export var jump_charge = 500

var motion = Vector2.ZERO
var is_jumping = false
var jump_power = jump_power_min

func _physics_process(delta):
	motion.y += gravity * delta
	if is_on_floor():
		if Input.is_action_pressed("right"):
			motion.x += acc * delta 
			if motion.x > speed:
				motion.x = speed
		elif Input.is_action_pressed("left"):
			motion.x -= acc * delta 
			if motion.x < -speed:
				motion.x = -speed
		else:
			if motion.x < -5:
				motion.x += deacc * delta
			elif motion.x > 5:
				motion.x -= deacc * delta
			else:
				motion.x = 0
	
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true

	if is_jumping and Input.is_action_pressed("jump"):
		if  jump_power < jump_power_max:
			jump_power += delta * jump_charge
		motion.x = 0
		
	if is_jumping and Input.is_action_just_released("jump"):
		if Input.is_action_pressed("right"):
			motion.x += jump_power
			
			if motion.x > speed:
				motion.x = speed
		if Input.is_action_pressed("left"):
			motion.x -= jump_power
			if motion.x < -speed:
				motion.x = -speed
		motion.y = -jump_power
		is_jumping = false
		jump_power = jump_power_min
	

	motion = move_and_slide(motion, Vector2.UP)

