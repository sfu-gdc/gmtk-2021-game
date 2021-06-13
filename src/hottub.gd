extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://src/scenes/menu/Menu.tscn")
