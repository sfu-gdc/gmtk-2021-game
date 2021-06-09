extends Sprite

onready var sprite_manager_ref: Node = get_node(NodePath("/root/Sample/SpriteManager"))

const player_left_rect = Rect2(0, 0, 8, 8)
const player_left2_rect = Rect2(0, 8, 8, 8)
const player_left3_rect = Rect2(0, 16, 8, 8)

const player_right_rect = Rect2(8, 0, 8, 8)
const player_right2_rect = Rect2(8, 8, 8, 8)
const player_right3_rect = Rect2(8, 16, 8, 8)

# animation vars:

onready var left_anim = [
	sprite_manager_ref.get_tex(player_left_rect),
	sprite_manager_ref.get_tex(player_left2_rect),
	sprite_manager_ref.get_tex(player_left3_rect)
]

onready var right_anim = [
	sprite_manager_ref.get_tex(player_right_rect),
	sprite_manager_ref.get_tex(player_right2_rect),
	sprite_manager_ref.get_tex(player_right3_rect)
]

var direction = "left"
var anim_on = false
var anim_step = 0.0
var step_time = 0.2
var cur_time = 0.0

# general vars:

var speed = 25.0

# Functions:
# ======================================== #

# Called when the node enters the scene tree for the first time.
func _ready():
	var tex: Texture = sprite_manager_ref.get_tex(player_left_rect)
	self.set_texture(tex)

# for animations
func _process(delta):
	anim_on = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	if Input.is_action_pressed("ui_left"):
		self.set_texture(left_anim[anim_step])
		self.position += Vector2(-speed, 0) * delta
	elif Input.is_action_pressed("ui_right"):
		self.set_texture(right_anim[anim_step])
		self.position += Vector2(speed, 0) * delta
		
	if anim_on:
		# case: update animation frame
		if cur_time >= step_time:
			cur_time -= step_time
			anim_step = 1 if anim_step >= len(left_anim)-1 else anim_step + 1
		
		cur_time += delta
	else:
		anim_step = 0
		self.set_texture(left_anim[0] if direction == "left" else right_anim[0])

func _unhandled_input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_right"):
			direction = "right"
			cur_time = 0
			anim_step = 1
		elif Input.is_action_just_pressed("ui_left"):
			direction = "left"
			cur_time = 0
			anim_step = 1
