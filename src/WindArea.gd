extends Area2D

onready var particles_ref: CPUParticles2D = get_node("CPUParticles2D")
onready var shape_ref: CollisionShape2D = get_node("CollisionShape2D")
var move_speed := 4000.0
var direction := Vector2(0, -1)

# Called when the node enters the scene tree for the first time.
func _ready():
	var extents = shape_ref.shape.extents
	particles_ref.emission_rect_extents.y = extents.x
	particles_ref.position.y = extents.y - 8
	particles_ref.lifetime = 0.39/20 * extents.y
	particles_ref.amount = 50/20 * extents.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for body in self.get_overlapping_bodies():
		if body.get_class() != "TileMap":
			body.apply_central_impulse(direction.normalized() * move_speed * delta)
