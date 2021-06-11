extends Node2D

const util = preload("res://src/util.gd")
const block_behaviour = preload("res://src/test/block_behaviour.gd")

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

# Map info

const map_size = Vector2(13, 32)
const num_init_tiles = 50
var world_map = []

# Block spawing:

var time_to_spawn_block = 0.5 # TODO: need to make this slowly increase, but start small. (need a few bursts & beginning to keep players on their toes.)
var block_timer = 0.0

# Prebuilt Functions:

# This class builds the world
func _ready():
	rand.randomize()
	
	# create background
	background_ref.position = Vector2(-48-8, -24)
	for y in range(-map_size.y/2-1, 4+1):
		for x in range(0, map_size.x/2 + 2):
			var back_node = Sprite.new()
			if rand.randi_range(0, 2) == 0:
				back_node.set_texture(sprite_manager_ref.get_tex(sprite_manager_ref.get("background_rect_pattern")))
			else: 
				back_node.set_texture(sprite_manager_ref.get_tex(sprite_manager_ref.get("background_rect")))
			back_node.set_position(Vector2(x*16, y*16))
			back_node.flip_h = rand.randi_range(0, 1) == 0
			back_node.flip_v = rand.randi_range(0, 1) == 0
			
			background_ref.add_child(back_node)

	# create ground
	ground_ref.position = Vector2(-32, 8)
	var offset = Vector2(-16, 0)
	for x in range(0, map_size.x):
		var body = util.static_rect_body(Vector2(8, 8))
		body.set_friction(0.0)
		
		var ground_node = Sprite.new()
		ground_node.set_texture(util.random_in(ground_choices, rand))
		ground_node.set_position(Vector2(x*8, 0) + offset)
		ground_node.flip_h = rand.randi_range(0, 1) == 0
		ground_node.add_child(body)
		
		ground_ref.add_child(ground_node)

	# create objects
	objects_ref.position = Vector2(-48, -24)
	world_map = util.list_comprehension(world_map, range(0, map_size.x * map_size.y), -1)
	for i in range(0, num_init_tiles):
		# TODO: assert a closeness measure -> can't be too close to another block or can't make groups that are too large
		var random_loc = random_tile_in_map()
		while util.mat2_get(world_map, map_size.x, random_loc) != -1:
			random_loc = random_tile_in_map()

		var block_id = rand.randi_range(0, len(block_choices)-1)
		util.mat2_set(world_map, map_size.x, random_loc, block_id)

		var block = Sprite.new()
		block.set_texture(block_choices[block_id])
		block.set_position(random_loc * 8)
		block.add_child(util.static_rect_body(Vector2(8, 8)))

		objects_ref.add_child(block)

func _process(delta):
	block_timer += delta
	
	if block_timer >= time_to_spawn_block:
		block_timer -= time_to_spawn_block
	
		var loc = null
		var dir = null
		match rand.randi_range(0, 1):
			0:
				loc = Vector2(-8, rand.randi_range(4, -24)) * 8 # TODO: only do this around the player's screen.
				dir = "right"
			1:
				loc = Vector2(8, rand.randi_range(4, -24)) * 8
				dir = "left"
		spawn_block(loc, dir) # TODO: (LOW) eventually, start spawning multiple blocks at the same time.

# Custom Functions:

func spawn_block(loc, dir):
	var tex_id = rand.randi_range(0, len(block_choices)-1)
	
	var block_body = util.static_rect_body(Vector2(8, 8))
	block_body.set_position(loc)
	block_body.set_name("Body")
	
	var block_sprite = Sprite.new()
	block_sprite.set_texture(block_choices[tex_id]) # pick a random texture
	block_sprite.set_position(loc)
	block_sprite.set_name("Sprite")
	
	var block = Node.new()
	block.add_child(block_body)
	block.add_child(block_sprite)
	block.set_script(block_behaviour)
	block.set("block_id", tex_id)
	block.set("move_dir", dir)
	
	objects_ref.add_child(block)

func random_tile_in_map():
	return Vector2(rand.randi_range(-1, 13), rand.randi_range(-32+4, 0+4))
	
