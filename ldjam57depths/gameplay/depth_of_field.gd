extends Sprite2D

@export var distance_from_camera : float = 0.0
var focus_distance : float = 0.0

func _ready():
	SIGNAL_BUS.focus_changed.connect(focus_changed)
	z_index = -distance_from_camera


func focus_changed(new_focus_distance):
	var strength = abs(clamp(((abs(distance_from_camera - new_focus_distance) - 5) / transform.get_scale().x), 0, 800))*2
	material.set_shader_parameter("strength", strength)
	focus_distance = new_focus_distance


func change_distance_from_camera(new_distance):
	distance_from_camera = new_distance
	var strength = abs(clamp(((abs(distance_from_camera - focus_distance)) / transform.get_scale().x), 0, 800))*2
	material.set_shader_parameter("strength", strength)
