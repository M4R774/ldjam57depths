extends Camera2D

@export var zoom_speed := 0.03
@export var min_zoom := 1.0
@export var max_zoom := 4.0
@export var game_area: Area2D

var area_center := Vector2.ZERO
var area_extents := Vector2.ZERO

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	var collision_shape = game_area.get_node("CollisionShape")
	if collision_shape and collision_shape.shape is RectangleShape2D:
		var rect_shape = collision_shape.shape as RectangleShape2D
		area_extents = rect_shape.extents
		area_center = game_area.global_position
	else:
		push_error("Pelialueella ei ole oikeanlaista CollisionShape2D:tä!")


func _process(_delta):
	_update_camera_position()


func _unhandled_input(event):
	if event.is_action_pressed("zoom_out"):
		zoom *= 1.0 - zoom_speed
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
		var new_focus = map_range(zoom.x, min_zoom, max_zoom, 0, 100)
		SIGNAL_BUS.focus_changed.emit(new_focus)
	elif event.is_action_pressed("zoom_in"):
		zoom *= 1.0 + zoom_speed
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
		var new_focus = map_range(zoom.x, min_zoom, max_zoom, 0, 100)
		SIGNAL_BUS.focus_changed.emit(new_focus)
	elif event.is_action_pressed("shutter"):
		SIGNAL_BUS.picture_taken.emit()


func map_range(value: float, low1: float, high1: float, low2: float, high2: float) -> float:
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)


func _update_camera_position():
	var viewport = get_viewport()
	var screen_size = viewport.get_visible_rect().size
	var screen_center = screen_size * 0.5
	var mouse_pos = viewport.get_mouse_position()
	
	# Korjattu laskukaava: hiiren offset jaetaan zoomilla, jotta se muunnetaan oikein maailman koordinaateiksi
	var new_offset = (mouse_pos - screen_center) * zoom * 2

	# Lasketaan tavoitesijainta siten, että kun hiiri on keskellä, kamera osuu pelialueen keskelle
	var target = area_center + new_offset

	# Lasketaan puolet kameran näkymästä maailman koordinaateissa (huomioidaan zoom)
	var half_viewport = (screen_size / zoom) * 0.5

	# Pelialueen rajat
	var area_min = area_center - area_extents
	var area_max = area_center + area_extents

	# Rajoitetaan target niin, että kameran näkymän reunoja ei pääse yli pelialueen
	target.x = clamp(target.x, area_min.x + half_viewport.x, area_max.x - half_viewport.x)
	target.y = clamp(target.y, area_min.y + half_viewport.y, area_max.y - half_viewport.y)

	position = target
