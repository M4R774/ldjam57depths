extends Button



func _on_pressed() -> void:
	var parent = get_parent()
	var focus = parent.material.get_shader_parameter("strength")
	if focus > 0:
		print("Not on focus")
		return
	print("On focus!!")
	SIGNAL_BUS.picture_taken.emit()
	parent.queue_free()
