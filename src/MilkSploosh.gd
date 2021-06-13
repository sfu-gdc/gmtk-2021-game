extends CPUParticles2D
# A script to make milk sploosh



func _on_MilkArea_body_entered(body):
	position = body.position
	emitting = true
