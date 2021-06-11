extends KinematicBody2D

var is_player_here: = false
var velocity: = Vector2(0, 0)
var acceleration: = 100
var player = null


func _physics_process(delta):
	if is_player_here:
		move_and_slide(velocity)
		velocity = (player.global_position - global_position).normalized() * 100

func _on_Hurtbox_area_entered(area):
	queue_free()


func _on_Visionbox_area_entered(area):
	player = area
	is_player_here = true


func _on_Visionbox_area_exited(area):
	is_player_here = false
