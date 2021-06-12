extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200.0

func _physics_process(delta):
	var direction: = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	velocity = direction * speed
	velocity = move_and_slide(velocity)
