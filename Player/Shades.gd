extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const FLIP_MAG := 30.0


onready var parent = $".."

# Called when the node enters the scene tree for the first time.

func _process(_delta):
	if parent.linear_velocity.x > FLIP_MAG and not flip_h:
		flip_h = true
	elif parent.linear_velocity.x < -FLIP_MAG and flip_h:
		flip_h = false
