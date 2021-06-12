extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var level = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelTemplate_pressed():
	print(level)
	get_tree().change_scene(level)
