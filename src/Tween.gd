extends Tween

func _ready():
# warning-ignore:return_value_discarded
	interpolate_property($"..", "color", Color(0.0, 0.0, 0.0, 1.0), Color(0.0, 0.0, 0.0, 0.0), 3.0)
# warning-ignore:return_value_discarded
	start()
