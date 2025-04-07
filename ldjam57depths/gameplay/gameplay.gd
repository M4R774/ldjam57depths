extends Node2D


func _ready():
    await get_tree().process_frame
    SIGNAL_BUS.focus_changed.emit(50.0)
    %Camera.zoom = Vector2((%Camera.min_zoom + %Camera.max_zoom) / 2, (%Camera.min_zoom + %Camera.max_zoom) / 2)
