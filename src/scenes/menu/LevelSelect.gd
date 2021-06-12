extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var level_index = 0
	var scene_name = ""
	for button in self.get_children():
		if button is Button:
			button.text = str(level_index + 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
