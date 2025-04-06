extends Timer


func _on_timeout() -> void:
    get_tree().paused = false
    SIGNAL_BUS.picture_taking_ended.emit()
