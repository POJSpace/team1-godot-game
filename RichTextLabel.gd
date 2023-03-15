extends RichTextLabel

const CONTENT = "Hello traveler, thanks for arriving after all those years"

func _ready():
	$Sprite.visible = true
	for i in CONTENT:
		yield(get_tree().create_timer(0.1), "timeout")
		text += i
	$Sprite.visible = false
