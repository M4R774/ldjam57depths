extends Label


func _process(delta):
    text = "%d FPS" % int(Engine.get_frames_per_second())
