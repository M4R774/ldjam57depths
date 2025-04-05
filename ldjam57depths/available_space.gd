extends Label


var free_space = 9001


func _ready():
	SIGNAL_BUS.picture_taken.connect(_on_focus_changed)


func _on_focus_changed():
	free_space -= 1
	text = str(free_space)
