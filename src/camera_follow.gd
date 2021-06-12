extends Camera2D

onready var player_body_ref = get_node(NodePath("/root/Main/Player/Sprite"))
var pan_speed = 3.5
var tracking_offset = Vector2(0, 0)

export var only_y = false

func _ready():
	tracking_offset = Vector2(4, 4) + Vector2(0, 8);
	
func _process(delta):
	var target = (player_body_ref.position) - self.get_camera_position()
	var translate = null
	if only_y:
		translate = Vector2(0, target.y) * delta * pan_speed
	else:
		translate = target * delta * pan_speed
	self.translate(translate)
