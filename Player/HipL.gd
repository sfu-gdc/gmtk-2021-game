extends Node2D

const frame_time = 0.125
const max_frame = 1

var cur_time = 0.0
var frame = 0

func _ready():
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_anim(delta)

func update_anim(delta):
	cur_time += delta
	
	if cur_time > frame_time:
		cur_time -= frame_time
		frame += 1
		if frame > max_frame:
			frame = 0
			
		update_frame()
	
func update_frame():
	if frame == 0:
		$SodaWater.hide()
		$SodaWaterFrame2.show()
	elif frame == 1:
		$SodaWater.show()
		$SodaWaterFrame2.hide()
