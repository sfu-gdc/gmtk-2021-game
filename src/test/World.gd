extends Node2D

onready var sprite_manager_ref: Node = get_node(NodePath("/root/Sample/SpriteManager"))
onready var background_ref: Sprite = find_node("Background")

# TODO: build textures here & place them down.
func _ready():
	var tex: Texture = sprite_manager_ref.get_tex(sprite_manager_ref.background_rect)
	background_ref.set_texture(tex)
