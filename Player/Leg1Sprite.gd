extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var step = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	step += delta
	if Input.is_action_pressed("move_left"):
		rotation_degrees = -(15 + sin(step*20) * 15)
	if Input.is_action_pressed("move_right"):
		rotation_degrees = (15 + cos(step*20) * 15)
