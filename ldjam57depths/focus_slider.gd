extends HSlider

@export var focus_min_distance : float = 0.0
@export var focus_max_distance : float = 100.0

@export var focus_in_sound : AudioStream = null
@export var focus_out_sound : AudioStream = null

@onready var focus_audio = $FocusSound

var old_focus_distance = 0

func _ready():
    min_value = focus_min_distance
    max_value = focus_max_distance
    SIGNAL_BUS.focus_changed.connect(change_value_from_signal)


func change_value_from_signal(new_focus:float) -> void:
    value = new_focus
    play_audio(new_focus)


func _on_value_changed(new_focus:float) -> void:
    SIGNAL_BUS.focus_changed.emit(new_focus)
    play_audio(new_focus)


func play_audio(new_focus) -> void:
    if !focus_audio.playing:
        if new_focus > old_focus_distance:
            focus_audio.stream = focus_in_sound
        else:
            focus_audio.stream = focus_out_sound
        focus_audio.play()
    old_focus_distance = new_focus