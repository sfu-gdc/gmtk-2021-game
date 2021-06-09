extends Camera2D

onready var player_body_ref = get_node(NodePath("/root/Sample/World/Player/Body"))
var pan_speed = 1.25
var tracking_offset = Vector2(0, 0)

var only_x = true

func _ready():
	tracking_offset = Vector2(4, 4) + Vector2(0, 8);
	
func _process(delta):
	var target = (player_body_ref.position) - self.get_camera_position()
	var translate = null
	if only_x:
		translate = Vector2(0, target.y) * delta * pan_speed
	else:
		translate = target * delta * pan_speed
	self.translate(translate)
