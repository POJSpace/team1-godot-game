extends KinematicBody2D

export var speed = 150
export var jump_speed = 250
export var jump_power_min = 200
export var jump_power_max = 725
export var gravity = 1300
export var acc = 600
export var deacc = 400 #akcelerace zastavení
export var jump_charge = 250
var collison_info
var v

onready var animation = $AnimationPlayer
onready var animation_tree = $AnimationTree

var landing = false
var motion = Vector2.ZERO
var is_jumping = false
var jump_power = jump_power_min

func _ready():
	animation_tree.active = true
	animation_tree = animation_tree.get("parameters/playback")
	
func _physics_process(delta):
	motion.y += gravity * delta
	if is_on_floor():
		if landing == true:
			motion.x = 0
			landing = false
		if Input.is_action_pressed("jump"):
			animation_tree.travel("ChargeJump")
			if Input.is_action_pressed("right"):
				$Texture.flip_h = false
			if Input.is_action_pressed("left"):
				$Texture.flip_h = true
		elif Input.is_action_pressed("right"):
			$Texture.flip_h = false #horizontal flip of the texture
			animation_tree.travel("Riding") 
			motion.x += acc * delta
			if motion.x > speed:
				motion.x = speed
		elif Input.is_action_pressed("left"):
			$Texture.flip_h = true #horizontal flip of the texture
			animation_tree.travel("Riding") 
			motion.x -= acc * delta 
			if motion.x < -speed:
				motion.x = -speed
		if motion.x > 5:
			motion.x -= deacc * delta
		elif motion.x < -5:
			motion.x += deacc * delta
		else:
			if ! Input.is_action_pressed("jump"):
				animation_tree.travel("Idle") 
			motion.x = 0
			
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
		
	if is_jumping and Input.is_action_pressed("jump"):
		if  jump_power <= jump_power_max:
			jump_power += delta * jump_charge
		motion.x = 0
		
	if is_jumping and Input.is_action_just_released("jump"):
		animation_tree.travel("Jump") 
		landing = true
		if Input.is_action_pressed("right"):
			motion.x += jump_power
			if motion.x > jump_speed:
				motion.x = jump_speed
		if Input.is_action_pressed("left"):
			motion.x -= jump_power
			if motion.x < -jump_speed:
				motion.x = -jump_speed
		motion.y = -jump_power
		is_jumping = false
		jump_power = jump_power_min
		
	collide_on_wall()
	
	motion = move_and_slide(motion, Vector2.UP)
	
func collide_on_wall():
	if motion.x !=0:
		v = motion.x
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider is TileMap and not is_on_floor():
			motion.x = collision.normal.x*abs(v)*0.35
	

