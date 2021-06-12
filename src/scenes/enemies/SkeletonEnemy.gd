extends KinematicBody2D

var velocity: = Vector2.ZERO
export var dash_speed: = 160
export var chase_speed: = 80
var gravity: = 1000
var player = null
var time = 0.0

enum {
	PREPARE,
	DASH,
	CHASE,
	STOP
}

var state: = STOP


func _physics_process(delta):
	match state:
		CHASE:
			chase(delta)
		DASH:
			dash(delta)
		STOP:
			stop(delta)


func chase(delta):
	velocity.x = chase_speed if player.global_position > global_position else -chase_speed
	move(delta)
	
	
func dash(delta):
	yield(get_tree().create_timer(1.0), "timeout")
	velocity.x = dash_speed if player.global_position > global_position else -dash_speed
	move(delta)
	

func stop(delta):
	velocity.x = 0.0
	move(delta)


func move(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)


func _on_Visionbox_area_entered(area):
	player = area
	state = CHASE


func _on_Visionbox_area_exited(area):
	state = STOP


func _on_Dashbox_area_entered(area):
	state = DASH
