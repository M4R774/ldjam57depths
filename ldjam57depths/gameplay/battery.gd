extends HSlider


func _ready():
    SIGNAL_BUS.picture_taken.connect(_on_picture_taken)


func _on_picture_taken():
    var battery_consume = randf_range(9.0, 11.0)
    if value > 9:
        value -= battery_consume
    else:
        value = 0
    $Label.text = "%02d" % [value] + " %"
