extends Tween

func _ready():
	interpolate_property($"..", "color", Color(0.0, 0.0, 0.0, 1.0), Color(0.0, 0.0, 0.0, 0.0), 3.0)
	start()
