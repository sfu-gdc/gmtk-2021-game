extends Button

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Rate_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://earthensky.itch.io/skeletied")
