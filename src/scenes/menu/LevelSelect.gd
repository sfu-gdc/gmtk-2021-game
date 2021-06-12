extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const button_scene = preload("res://src/scenes/menu/LevelButtonTemplate.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var level_index = 0
	var levels = ["res://src/scenes/menu/Menu.tscn","","","","res://src/scenes/menu/Menu.tscn","","","","res://src/scenes/menu/Menu.tscn","","",""]
	var level_count = 2
	var menu_y = 64 + 16
	var menu_x_start = 64
	var menu_x_seperation = 96
	
	for levelName in levels:
		var button = button_scene.instance()
		button.text = str(level_index + 1)
		var row_number = floor(level_index/4)
		var y_offset = (108 * (row_number))
		button.set_position(Vector2(menu_x_start + ((-480 + menu_x_start + 30) * row_number) + (level_index * menu_x_seperation),menu_y + y_offset))
		self.add_child(button)
		
		level_index += 1
#	for button in scene.get_children():
#		button.text = "1"
	
#	for button in self.get_children():
#		if button is Button:
#			button.level = levels[level_index]
#			button.text = str(level_index + 1)
#			level_index += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
