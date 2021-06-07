extends Node

const util = preload("res://src/util.gd")

onready var world_ref = get_node("/root/Sample/World/")
var body = null
var sprite = null

var block_id = null
var move_dir = null
var offset = null

var block_speed = 2.0

func _ready():
	print("block instantiated " + str(block_id))
	body = get_child(0)
	sprite = get_child(1)
	match move_dir:
		"left":
			offset = Vector2(-1, 0)
		"right":
			offset = Vector2(1, 0)

func _process(delta):
	var last_pos = sprite.position
	
	body.position += offset * delta * block_speed
	sprite.position = util.vec_round(body.position)
	
	# I'm not sorry about this line
	#if sprite.position != last_pos && abs(sprite_pos.x % 8) < 0.01 && abs(sprite_pos.y % 8) < 0.01 && util.mat2_get(world_ref.get("world_map"), world_ref.get("map_size").x, sprite.position / 8 + offset) == true:
		# TODO: offset & move the entire row
		#pass
