extends Area2D
# A script for PhysicsButtons

signal button_on
signal button_off


var pressers := []


onready var sprite := $AnimatedSprite


func _on_PhysicsButton_body_entered(body):
	if not body in pressers:
		pressers.append(body)
		if sprite.frame == 0:
			sprite.frame = 1
			emit_signal("button_on")

func _on_PhysicsButton_body_exited(body):
	var body_index: int = pressers.find(body)
	if body_index != -1:
		pressers.remove(body_index)
		if sprite.frame == 1 and pressers.size() == 0: 
			sprite.frame = 0
			emit_signal("button_off")
