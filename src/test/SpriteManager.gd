extends Node

const player_left_rect = Rect2(0, 0, 8, 8)
const player_right_rect = Rect2(1*8, 0, 8, 8)
const ground_rect = Rect2(3*8, 0, 8, 8)
const background_rect = Rect2(6*8, 0, 16, 16)

var player_left_tex = null
var player_right_tex = null
var ground_tex = null
var background_tex = null

func _ready():
	var spritesheet = load("res://res/sample_tileset.png")
	 # makes it so that the texture isn't blurry & doesn't have weird aliasing effects.
	spritesheet.set_flags(Texture.FLAG_MIPMAPS)
	
	player_left_tex = AtlasTexture.new()
	player_left_tex.set_atlas(spritesheet)
	player_left_tex.set_region(player_left_rect)
	
	player_right_tex = AtlasTexture.new()
	player_right_tex.set_atlas(spritesheet)
	player_right_tex.set_region(player_right_rect)
	
	ground_tex = AtlasTexture.new()
	ground_tex.set_atlas(spritesheet)
	ground_tex.set_region(ground_rect)
	
	background_tex = AtlasTexture.new()
	background_tex.set_atlas(spritesheet)
	background_tex.set_region(background_rect)
