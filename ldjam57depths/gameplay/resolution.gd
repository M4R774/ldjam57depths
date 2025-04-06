extends Label

func _process(delta) -> void:
    var size = DisplayServer.window_get_size()
    text = "%dx%d" % [size.x, size.y]
