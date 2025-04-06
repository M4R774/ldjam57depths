extends Node2D


func _ready():
    SIGNAL_BUS.focus_changed.emit(0.0)