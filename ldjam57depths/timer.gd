extends Label


var elapsed_time := 0.0
var frame_count := 0
const TARGET_FPS := 60

func _process(delta: float) -> void:
    elapsed_time += delta
    frame_count = int(int(elapsed_time * TARGET_FPS) % TARGET_FPS)

    var hours = int(elapsed_time) / 3600
    var minutes = (int(elapsed_time) % 3600) / 60
    var seconds = int(elapsed_time) % 60

    var time_string = "%02d:%02d:%02d:%02d" % [hours, minutes, seconds, frame_count]
    text = time_string