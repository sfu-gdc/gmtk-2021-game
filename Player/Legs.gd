extends RigidBody2D
# A script to make the legs controllable


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


# Tell whether player legs on ground or not
func _on_GroundDetector_body_entered(body):
	if body.is_in_group("jumpable"):
		floors.append(body)

func _on_GroundDetector_body_exited(body):
	var body_index := floors.find(body)
	if body_index != -1 and floors.size() > 0:
		floors.remove(body_index)
