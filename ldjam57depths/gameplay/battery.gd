extends HSlider


func _ready():
    SIGNAL_BUS.picture_taking_ended.connect(_on_picture_taken)


func _on_picture_taken():
    pass
    var battery_consume = randf_range(9.0, 11.0)
    reduce_battery(battery_consume)


func _on_timer_timeout():
    var battery_consume = randf_range(0.0, 1.0)
    reduce_battery(battery_consume)


func reduce_battery(amount):
    if value > amount:
        value -= amount
    else:
        value = 0
        SIGNAL_BUS.game_over.emit("YOU RAN OUT OF BATTERY")
    $Label.text = "%02d" % [value] + " %"
