extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the Area2D node to detect collision with
	var TopArea = $TopArea
	var BottomArea = $BottomArea
	# Connect the collision signal to the _on_Area2D_body_entered function
	TopArea.connect("body_entered", self, "_on_TopArea_body_entered")
	BottomArea.connect("body_entered", self, "_on_BottomArea_body_entered")
	
# Function to be called when a collision is detected
func _on_TopArea_body_entered(body):
	# Check if the colliding body is a KinematicBody2D
	if body is KinematicBody2D:
		# Move the camera by -600 pixels on the y-axis
		position.y -= 600
		
func _on_BottomArea_body_entered(body):
	# Check if the colliding body is a KinematicBody2D
	if body is KinematicBody2D:
		# Move the camera by -600 pixels on the y-axis
		position.y += 600
