extends AudioStreamPlayer2D

func _ready():
    SIGNAL_BUS.picture_taken.connect(play_click)


func play_click():
    play()
