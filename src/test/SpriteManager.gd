extends Node

const ground_rect = Rect2(3*8, 0, 8, 8)
const ground2_rect = Rect2(3*8, 1*8, 8, 8)
const ground3_rect = Rect2(3*8, 2*8, 8, 8)
const block_rect = Rect2(2*8, 0, 8, 8)
const block2_rect = Rect2(2*8, 1*8, 8, 8)
const block3_rect = Rect2(2*8, 2*8, 8, 8)
const block4_rect = Rect2(2*8, 3*8, 8, 8)
const background_rect = Rect2(6*8, 0, 16, 16)
const background_rect_pattern = Rect2(6*8, 16, 16, 16)

var spritesheet = load("res://res/sample_tileset.png")

var ground_tex = null
var background_tex = null

func _ready():
	 # makes it so that the texture isn't blurry & doesn't have weird aliasing effects.
	spritesheet.set_flags(Texture.FLAG_MIPMAPS)
	
	ground_tex = AtlasTexture.new()
	ground_tex.set_atlas(spritesheet)
	ground_tex.set_region(ground_rect)
	
	background_tex = AtlasTexture.new()
	background_tex.set_atlas(spritesheet)
	background_tex.set_region(background_rect)

func get_tex(rect):
	var tex = AtlasTexture.new()
	tex.set_atlas(spritesheet)
	tex.set_region(rect)
	return tex
