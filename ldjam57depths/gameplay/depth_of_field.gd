extends Sprite2D

@export var distance_from_camera : float = 0.0
@export var background : bool = false
var focus_distance : float = 0.0

func _ready():
	material = material.duplicate()
	SIGNAL_BUS.focus_changed.connect(focus_changed)
	if background:
		z_index = distance_from_camera - 1000
	else:
		z_index = -distance_from_camera


func focus_changed(new_focus_distance):
	var strength = abs(clamp(((abs(distance_from_camera - new_focus_distance) - 5) / transform.get_scale().x), 0, 1600))*2
	material.set_shader_parameter("strength", strength)
	focus_distance = new_focus_distance
	if background:
		z_index = distance_from_camera - 1000
	else:
		z_index = -distance_from_camera


func change_distance_from_camera(new_distance):
	distance_from_camera = new_distance

	var h_diff_from_camera = abs(%Camera.global_position.x - global_position.x)/80

	var strength = abs(clamp(((abs(distance_from_camera - focus_distance) + h_diff_from_camera) / transform.get_scale().x), 0, 1600))*2
	material.set_shader_parameter("strength", strength)
	z_index = -distance_from_camera
