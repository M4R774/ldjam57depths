extends AnimationPlayer

func _ready() -> void:
	SIGNAL_BUS.picture_taken.connect(play_animation)


func play_animation() -> void:
	play("shutter")
