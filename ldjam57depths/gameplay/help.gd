extends Label

var activation_counter = 0

func _ready():
    SIGNAL_BUS.focus_changed.connect(focus_changed)


func focus_changed(_new_focus_distance):
    print("focus_changed")
    activation_counter += 1
    if activation_counter <= 10:
        return
    visible = false
