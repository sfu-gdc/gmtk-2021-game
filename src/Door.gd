extends KinematicBody2D
# A script for openable doors


export var POS_INIT := Vector2()
export var POS_FINAL := Vector2()


onready var tween = $Tween


func _on_PhysicsButton_button_on():
	tween.remove_all()
	tween.interpolate_property(self, "position", position, POS_FINAL, 0.2)
	tween.start()

func _on_PhysicsButton_button_off():
	tween.remove_all()
	tween.interpolate_property(self, "position", position, POS_INIT, 0.2)
	tween.start()
