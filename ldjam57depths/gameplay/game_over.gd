extends ColorRect


func _ready() -> void:
    # Connect the signal to the function
    visible = false
    SIGNAL_BUS.game_over.connect(_on_game_over)


func _on_game_over(reason) -> void:
    visible = true

    $Label.text = "YOU DIED\n\nREASON: %s" % reason
    # TODO: Wilhelm scream
