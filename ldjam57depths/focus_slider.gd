extends HSlider

@export var focus_min_distance : float = 0.0
@export var focus_max_distance : float = 100.0


func _ready():
    min_value = focus_min_distance
    max_value = focus_max_distance


func _on_value_changed(new_focus:float) -> void:
    SIGNAL_BUS.focus_changed.emit(new_focus)
