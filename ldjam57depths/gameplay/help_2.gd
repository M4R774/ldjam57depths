extends Label


func _ready():
    SIGNAL_BUS.picture_taken.connect(picture_taken)


func picture_taken():
    visible = false