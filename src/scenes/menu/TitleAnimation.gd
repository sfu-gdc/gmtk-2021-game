extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rotation_ammt = 6
var growth_max = 1
var growth_min = 0.95
var step = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	step += delta
	self.rotation_degrees = sin(step) * rotation_ammt
	self.scale.y = growth_min + abs(sin(step/2) * (growth_max-growth_min))
	self.scale.x = growth_min + abs(cos(step/2) * (growth_max-growth_min))
