extends Button

func _ready():
	connect("pressed", _on_pressed)

func _on_pressed():
	get_tree().change_scene_to_file("res://gameplay/gameplay.tscn")
