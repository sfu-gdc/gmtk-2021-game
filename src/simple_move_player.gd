extends Node

onready var sprite: Sprite = find_node("Sprite")
onready var body: RigidBody2D = find_node("RigidBody2D")

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_key_pressed(KEY_D):
		body.apply_central_impulse(Vector2(400,0))
	elif Input.is_key_pressed(KEY_A):
		body.apply_central_impulse(Vector2(-400,0))
	elif Input.is_key_pressed(KEY_S):
		body.apply_central_impulse(Vector2(0,400))
	elif Input.is_key_pressed(KEY_W):
		body.apply_central_impulse(Vector2(0,-400))
	else:
		pass

	sprite.position = body.position
