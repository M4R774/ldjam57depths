extends ColorRect


var score = 0


func _ready() -> void:
	# Connect the signal to the function
	visible = false
	score = 0
	SIGNAL_BUS.game_over.connect(_on_game_over)
	SIGNAL_BUS.add_score.connect(_on_add_score)


func _on_add_score(points: int, _noise: float) -> void:
	score += points


func _on_game_over(reason) -> void:
	visible = true

	$Label.text = "%s\nSCORE: %s\n" % [reason, score]
	# YOU RAN OUT OF BATTERY  /  YOU TOOK A BAD PICTURE
	# SCORE: 123123123
	# THANKS FOR PLAYING
	# TODO: Score
	# TODO: Wilhelm scream
