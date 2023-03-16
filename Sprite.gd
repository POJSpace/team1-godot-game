extends Sprite


const CONTENT = "Hello traveller, Welcome on Athora. You heard well, this planet is called Athora. You are on a really important mission here, you were selected by our magical council to repair core of this planet. PLEASE you are our last chance. I wish you good luck. Have fun"


func _ready():
	get_parent().visible = true
	for i in CONTENT:
		yield(get_tree().create_timer(0.1), "timeout")
		$RichTextLabel.text += i
	get_parent().visible = false
