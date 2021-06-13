extends CPUParticles2D
# A script to make milk sploosh



func _on_MilkArea_body_entered(body):
	if body.position.x > 100.0:
		position = body.position
		emitting = true
