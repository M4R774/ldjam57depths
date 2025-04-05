extends AudioStreamPlayer2D

func _ready():
    SIGNAL_BUS.picutre_taken.connect(play_click)


func play_click():
    play()