extends Node

onready var sprite: Sprite = find_node("Sprite")
onready var body: RigidBody2D = find_node("RigidBody2D")

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_D):
		body.linear_velocity += Vector2(4,0)
	elif Input.is_key_pressed(KEY_A):
		body.linear_velocity -= Vector2(4,0)
	elif Input.is_key_pressed(KEY_S):
		body.linear_velocity += Vector2(0,4)
	elif Input.is_key_pressed(KEY_W):
		body.linear_velocity -= Vector2(0,4)
	else:
		pass

	sprite.position = body.position
