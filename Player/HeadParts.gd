extends Sprite
# Makes the head flip depending on motion


const FLIP_MAG := 30.0


onready var parent = $".."


func _process(_delta):
	if parent.linear_velocity.x > FLIP_MAG and not flip_h:
		flip_h = true
	elif parent.linear_velocity.x < -FLIP_MAG and flip_h:
		flip_h = false
