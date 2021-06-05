extends Node2D

onready var sprite_manager_ref = get_node(NodePath("/root/Sample/SpriteManager"))
onready var background_ref = find_node("Background")

# TODO: build textures here & place them down.
func _ready():
	background_ref.set_texture(sprite_manager_ref.get("background_tex"))
