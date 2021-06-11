extends Node

# const:

const util = preload("res://src/util.gd")

const player_left_rect = Rect2(0, 0, 8, 8)
const player_left2_rect = Rect2(0, 8, 8, 8)
const player_left3_rect = Rect2(0, 16, 8, 8)

const player_right_rect = Rect2(8, 0, 8, 8)
const player_right2_rect = Rect2(8, 8, 8, 8)
const player_right3_rect = Rect2(8, 16, 8, 8)

const particle_rect = Rect2(7*8, 7*8, 8, 8)

const grab_distance = 2.01

# node references:

onready var sprite_manager_ref = get_node(NodePath("/root/Sample/SpriteManager"))
onready var sprite = find_node("Sprite");
onready var body = find_node("Body");

var jumpParticles = CPUParticles2D.new() # b/c gles2

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

var anim_on = false
var anim_step = 0
var step_time = 0.22
var cur_time = 0

# object properties:

var infinite_jumping = false
var touching_ground = true
var jump_time_limit = 0.06 # must wait ~60ms between jumps no matter what
var jump_timer = 0
var direction = "left"

# functions:
# ============================================== #

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.set_texture(left_anim[0])

	body.add_child(util.circle_collider(4))
	body.gravity_scale = 2.0
	body.friction = 0.0
	body.set_mode(RigidBody2D.MODE_CHARACTER)
	body.set_position(Vector2(0, -24))
	
	jumpParticles.texture = sprite_manager_ref.get_tex(particle_rect)
	jumpParticles.gravity = Vector2(0, 0)
	jumpParticles.spread = 45
	jumpParticles.initial_velocity = 80
	jumpParticles.explosiveness = 1.0
	jumpParticles.lifetime = 0.9
	jumpParticles.damping = 95
	jumpParticles.amount = 6
	
	jumpParticles.rotate(PI * 0.5)
	
	self.add_child(jumpParticles)

# for animations
func _process(delta):
	anim_on = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	if Input.is_action_pressed("ui_left"):
		sprite.set_texture(left_anim[anim_step])
	elif Input.is_action_pressed("ui_right"):
		sprite.set_texture(right_anim[anim_step])
		
	if Input.is_action_just_pressed("ui_home"):
		infinite_jumping = not infinite_jumping
		
	if anim_on:
		if cur_time >= step_time: # case: update animation frame
			cur_time -= step_time
			anim_step = 1 if anim_step >= len(left_anim)-1 else anim_step + 1
		
		cur_time += delta
	else:
		anim_step = 0
		sprite.set_texture(left_anim[0] if direction == "left" else right_anim[0])
	
# NOTE: see PostProcess for position updating
func _physics_process(delta):
	if not touching_ground:
		jump_timer += delta
		
		# TODO: make it so that the player can't jump unless their vertical speed is slow enough -> enable only double jumps -> maybe put a speed limit.
		if jump_timer >= jump_time_limit && _physics_is_touching_ground():
			#jump_timer = 0 # don't need to reset timer here
			touching_ground = true
	elif not _physics_is_touching_ground():
		touching_ground = false
		jump_timer = 0

	if Input.is_action_just_pressed("ui_up") and jump_timer >= jump_time_limit and _physics_can_grab():
		jump(body)
		jump_timer = 0
	elif Input.is_action_just_pressed("ui_up") and (touching_ground or infinite_jumping):
		jump(body)
		touching_ground = false
		jump_timer = 0
	elif Input.is_action_pressed("ui_left"):
		body.linear_velocity.x = -25
	elif Input.is_action_pressed("ui_right"):
		body.linear_velocity.x = 25
	else:
		body.linear_velocity.x = 0
		
	sprite.position = util.vec_round(body.position)
	# TODO: (LOW) double check if the current position is in any of the boxes. If it is, then don't move. 
	# -> do a physics point cast... or something -> or do a manual collision right here.

func _unhandled_input(event):
	if event is InputEventKey:
		if Input.is_action_just_released("ui_right"):
			direction = "right"
		elif Input.is_action_just_pressed("ui_right"):
			direction = "right"
			cur_time = 0
			anim_step = 1
		elif Input.is_action_just_released("ui_left"):
			direction = "left"
		elif Input.is_action_just_pressed("ui_left"):
			direction = "left"
			cur_time = 0
			anim_step = 1

# My functions:

# can only be called in _physics_process()
func _physics_is_touching_ground():
	var space_state = body.get_world_2d().direct_space_state
	
	var under_foot_shape = RectangleShape2D.new()
	under_foot_shape.extents = Vector2(3, 0.125) # TODO: maybe make the collider a bit thinner.
		
	var shape_params = Physics2DShapeQueryParameters.new()
	shape_params.set_shape(under_foot_shape)
	shape_params.transform = Transform2D(0, Vector2(0, 0.5) + body.position + Vector2(0, 4))
	
	var results = space_state.collide_shape(shape_params, 1)
	return len(results) != 0

func _physics_can_grab() -> bool:
	var space_state = body.get_world_2d().direct_space_state
	
	# TODO: need top & middle ray to hit. so player can only grab with top half of body?
	var ray = Vector2(1, 0) if direction == "right" else Vector2(-1, 0)
	
	var results = space_state.intersect_ray(body.global_position, body.global_position + ray * 16, [self])
	if len(results) == 0:
		return false
	else:
		#print(body.global_position.distance_to(results["position"]) - 4)
		return body.global_position.distance_to(results["position"]) - 4 <= grab_distance

func jump(body: RigidBody2D) -> void:
	if body.linear_velocity.y > 0:
		body.linear_velocity.y = 0
	
	body.apply_central_impulse(Vector2(0, -85))
	
	# burst particles here.
	throw_some_particles(Vector2(0, 1)) # TODO: this
	
func throw_some_particles(direction: Vector2) -> void:
	pass # todo: custom particles that chooses from the three, makes sure they don't overlap, & collide with the ground & each other. (circle hitbox, but have friction.)
