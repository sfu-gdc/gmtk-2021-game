extends Node

const ground_rect = Rect2(3*8, 0, 8, 8)
const ground2_rect = Rect2(3*8, 1*8, 8, 8)
const ground3_rect = Rect2(3*8, 2*8, 8, 8)
const block_rect = Rect2(2*8, 0, 8, 8)
const block2_rect = Rect2(2*8, 1*8, 8, 8)
const block3_rect = Rect2(2*8, 2*8, 8, 8)
const block4_rect = Rect2(2*8, 3*8, 8, 8)
const background_rect = Rect2(6*8, 0, 16, 16)

var spritesheet: Texture = load("res://res/sample_tileset.png")

func _ready():
	 # makes it so that the texture isn't blurry & doesn't have weird aliasing effects.
	spritesheet.set_flags(Texture.FLAG_MIPMAPS)

# I could theoretically return AtlasTexure, but we don't really want people 
# messing with the region of a texture atlas.
func get_tex(rect: Rect2) -> Texture:
	var tex = AtlasTexture.new()
	tex.set_atlas(spritesheet)
	tex.set_region(rect)
	return tex
