extends AudioStreamPlayer


@export var excellent_picture_sounds : Array[AudioStream] = []
@export var good_picture_sounds : Array[AudioStream] = []
@export var ok_picture_sounds : Array[AudioStream] = []
@export var not_terrible_picture_sounds : Array[AudioStream] = []
@export var bad_picture_sounds : Array[AudioStream] = []
@export var terrible_picture_sounds : Array[AudioStream] = []

func _ready():
    SIGNAL_BUS.add_score.connect(_on_picture_taken)


func _on_picture_taken(_score: int, noise: float):
    if noise > 40:
        print("TERRIBLE PICTURE: ", noise)
        play_random_sound(terrible_picture_sounds)
    elif noise > 8:
        print("BAD PICTURE: ", noise)
        play_random_sound(bad_picture_sounds)
    elif noise > 6:
        print("NOT TERRIBLE PICTURE: ", noise)
        play_random_sound(not_terrible_picture_sounds)
    elif noise > 4:
        print("OK PICTURE: ", noise)
        play_random_sound(ok_picture_sounds)
    elif noise > 2:
        print("GOOD PICTURE: ", noise)
        play_random_sound(good_picture_sounds)
    else:
        print("EXCELLENT PICTURE: ", noise)
        play_random_sound(excellent_picture_sounds)


func play_random_sound(sounds: Array[AudioStream]):
    if sounds.size() == 0:
        return
    var random_index = randi() % sounds.size()
    stream = sounds[random_index]
    play()
