extends CPUParticles2D
# A script to make milk sploosh

var mody_boi
var tween

func _ready():
	if get_tree().get_root().get_children()[0].name == "Main":
		mody_boi = $"../../Fade/CanvasModulate"
		tween = $"../../Fade/CanvasModulate/Tween"


func _on_MilkArea_body_entered(body):
	if body.position.x > 100.0:
		position = body.position
		emitting = true
		if get_tree().get_root().get_children()[0].name == "Main":
			var t = Timer.new()
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			
			tween.interpolate_property(mody_boi, "modulate", Color(0.0, 0.0, 0.0, 0.0), Color(0.0, 0.0, 0.0, 1.0), 2.0)
			tween.start()
			
			t.start()
			yield(t, "timeout")
			tween.remove_all()
			tween.queue_free()
			t.queue_free()
	# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/hottub.tscn")
