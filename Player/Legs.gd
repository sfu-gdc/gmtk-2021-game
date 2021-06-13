extends RigidBody2D
# A script to make the legs controllable

var self_scene = load("res://Player/Player.tscn")

export var area: int = -1
var area_2_checkpoints = [Vector2(0, 0), Vector2(-420, -2400)]
var cur_checkpoint_index = 0 
var reset_pos = false

# Constants
const GROUND_ACCEL := 20_000.0
const AIR_ACCEL := 5000.0
const JUMP_STR := 10_000.0

# Properties
var floors := []

func _physics_process(delta):
	# Add a left or right force with keys
	var accel = GROUND_ACCEL if floors.size() > 0 else AIR_ACCEL
	if Input.is_action_pressed("move_right"):
		apply_central_impulse(delta * accel * Vector2(1.0, 0.0))
	if Input.is_action_pressed("move_left"): 
		apply_central_impulse(delta * accel * Vector2(-1.0, 0.0))

	# Jump if on ground
	if Input.is_action_just_pressed("jump") and floors.size() > 0:
		apply_central_impulse(JUMP_STR * Vector2(0.0, -1.0))

	if reset_pos:
		var instance = self_scene.instance()
		self.get_parent().name = "nothing"
		self.get_parent().get_parent().add_child(instance)
		self.get_parent().queue_free()

	#print(self.get_parent().find_node("Head").position)

# Tell whether player legs on ground or not
func _on_GroundDetector_body_entered(body):
	if body.is_in_group("jumpable"):
		floors.append(body)
	elif body.is_in_group("killer"):
		if area == 2:
			reset_pos = true

func _on_GroundDetector_body_exited(body):
	var body_index := floors.find(body)
	if body_index != -1 and floors.size() > 0:
		floors.remove(body_index)

func _on_GroundDetector_area_entered(area):
	if area.is_in_group("checkpoint"):
		cur_checkpoint_index = int(area.name)
		print("checkpoint Up! : " + area.name)

#func set_pos(loc: Vector2):
#	var i = 0
#	for child in get_parent().get_children():
#		print(child.name)
#		if child.get_class() != "Node2D": 
#			child.position = loc + Vector2(1, 0) * i
#		elif child.get_class() == "Node2D":
#			for second_child in child.get_children():
#				#if second_child.get_class() == "RigidBody2D": 
#				second_child.position = loc + Vector2(1, 0) * i
#				i += 1		
#		i += 1
