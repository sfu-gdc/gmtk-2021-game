extends Node2D

onready var sprite_manager_ref = get_node(NodePath("/root/Sample/SpriteManager"))
onready var background_ref = find_node("Background")
onready var ground_ref = find_node("Ground")

var rand = RandomNumberGenerator.new()

onready var ground_choices = [
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground2_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground3_rect"))
]

# This class builds the world
func _ready():
	rand.seed = 99
	background_ref.position = Vector2(-48, -24)
	for y in range(0, 4):
		for x in range(0, 7):
			var back_node = Sprite.new()
			back_node.set_texture(sprite_manager_ref.get("background_tex"))
			back_node.set_position(Vector2(x*16, y*16))
			back_node.flip_h = rand.randi_range(0, 1) == 0
			back_node.flip_v = rand.randi_range(0, 1) == 0
			background_ref.add_child(back_node)
	
	ground_ref.position = Vector2(-32, 8)
	for x in range(0, 9):
		var ground_node = Sprite.new()
		ground_node.set_texture(ground_choices[rand.randi_range(0, 3)])
		ground_node.set_position(Vector2(x*8, 0))
		ground_node.flip_h = rand.randi_range(0, 1) == 0
		ground_ref.add_child(ground_node)
