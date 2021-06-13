extends RigidBody2D
# A script to make the hands move and follow the mouse


# Constants
const TORQUE_STR := 2_000_000.0


var grabbable_objects := []
var grab_points := []


onready var world = get_tree().get_root().get_children()[-1]
onready var head := $"../Head"
onready var sound := $"../GrabSound"


func _physics_process(delta):
	# Make hand chase cursor
	apply_torque_impulse(delta * TORQUE_STR * (position - head.position).normalized().cross((get_global_mouse_position() - position).normalized()))
	
	# Grab objects if grab button
	if Input.is_action_just_pressed("grab"):
		for body in grabbable_objects:
			var grab_point = PinJoint2D.new()
			grab_point.position = position
			grab_point.node_a = self.get_path()
			grab_point.node_b = body.get_path()
			world.add_child(grab_point)
			grab_points.append(grab_point)
			sound.play()
	if Input.is_action_just_released("grab"):
		for grab_point in grab_points:
			grab_point.queue_free()
		grab_points.clear()




func _on_Area2D_body_entered(body):
	if body.is_in_group("grabbable"):
		grabbable_objects.append(body)

func _on_Area2D_body_exited(body):
	var body_index := grabbable_objects.find(body)
	if body_index != -1:
		grabbable_objects.remove(body_index)
