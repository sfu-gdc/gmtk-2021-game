extends Sprite

onready var sprite_manager_ref = get_node(NodePath("/root/Sample/SpriteManager"))

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_texture(sprite_manager_ref.get("ground_tex"))
