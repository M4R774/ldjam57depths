extends Sprite2D

@export var distance_from_camera : float = 0.0


func _ready():
    SIGNAL_BUS.focus_changed.connect(focus_changed)
    z_index = -distance_from_camera


func focus_changed(new_focus_distance):
    var strength = abs(distance_from_camera - new_focus_distance)/10
    material.set_shader_parameter("strength", strength)
    # TODO: Blur image
