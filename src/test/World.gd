extends Node2D

const util = preload("res://src/util.gd")

onready var sprite_manager_ref = get_node(NodePath("/root/Sample/SpriteManager"))
onready var background_ref = find_node("Background")
onready var ground_ref = find_node("Ground")
onready var objects_ref = find_node("Interactables")

var rand = RandomNumberGenerator.new()

onready var ground_choices = [
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground2_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("ground3_rect"))
]

onready var block_choices = [
	sprite_manager_ref.get_tex(sprite_manager_ref.get("block_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("block2_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("block3_rect")),
	sprite_manager_ref.get_tex(sprite_manager_ref.get("block4_rect"))
]

# This class builds the world
func _ready():
	rand.seed = 99 # TODO: get this from current time
	
	# create background
	background_ref.position = Vector2(-48, -24)
	for y in range(0, 4):
		for x in range(0, 7):
			var back_node = Sprite.new()
			back_node.set_texture(sprite_manager_ref.get("background_tex"))
			back_node.set_position(Vector2(x*16, y*16))
			back_node.flip_h = rand.randi_range(0, 1) == 0
			back_node.flip_v = rand.randi_range(0, 1) == 0
			
			background_ref.add_child(back_node)

	# create ground
	ground_ref.position = Vector2(-32, 8)
	for x in range(0, 9):
		var ground_node = Sprite.new()
		ground_node.set_texture(util.random_in(ground_choices, rand))
		ground_node.set_position(Vector2(x*8, 0))
		ground_node.flip_h = rand.randi_range(0, 1) == 0
		var body = util.static_rect_body(Vector2(8, 8))
		body.set_friction(0.0)
		ground_node.add_child(body)
		ground_ref.add_child(ground_node)

	# create objects
	objects_ref.position = Vector2(-48, -24)
	var taken_locations = {}
	for i in range(0, 15):
		var random_loc = Vector2(rand.randi_range(0, 10) * 8 + 8, rand.randi_range(-1, 4) * 8 + 8)
		while random_loc in taken_locations:
			random_loc = Vector2(rand.randi_range(0, 10) * 8 + 8, rand.randi_range(-1, 4) * 8 + 8)
		taken_locations[random_loc] = true
		
		#var shape = RectangleShape2D.new()
		#shape.extents = Vector2(4, 4)

		#var collider = CollisionShape2D.new()
		#collider.set_shape(shape)

		#var body = StaticBody2D.new()
		#body.add_child(collider)

		var block = Sprite.new()
		block.set_texture(util.random_in(block_choices, rand))
		block.set_position(random_loc)
		block.add_child(util.static_rect_body(Vector2(8, 8)))
		
		objects_ref.add_child(block)
