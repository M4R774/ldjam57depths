extends HSlider


func _ready():
    SIGNAL_BUS.picture_taken.connect(_on_picture_taken)


func _on_picture_taken():
    var battery_consume = randf_range(9.0, 11.0)
    reduce_battery(battery_consume)


func _on_timer_timeout():
    var battery_consume = randf_range(0.0, 0.6)
    reduce_battery(battery_consume)


func reduce_battery(amount):
    if value > amount:
        value -= amount
    else:
        value = 0
        SIGNAL_BUS.game_over.emit("YOU RAN OUT OF BATTERY")
    $Label.text = "%02d" % [value] + " %"
