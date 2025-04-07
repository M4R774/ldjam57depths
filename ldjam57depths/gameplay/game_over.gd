extends ColorRect

@export var polaroid_scene: PackedScene

var score = 0


func _ready() -> void:
	# Connect the signal to the function
	visible = false
	score = 0
	SIGNAL_BUS.game_over.connect(_on_game_over)
	SIGNAL_BUS.add_score.connect(_on_add_score)


func _on_add_score(points: int, noise: float) -> void:
	score += points

	var img := take_screenshot()
	var polaroid_scene_instance = polaroid_scene.instantiate()
	polaroid_scene_instance.texture = ImageTexture.create_from_image(img)
	polaroid_scene_instance.get_node("Label").text = get_string_from_noise(noise)
	$HBoxContainer.add_child(polaroid_scene_instance)


func _on_game_over(reason) -> void:
	visible = true

	$Label.text = "%s\nSCORE: %s" % [reason, score]
	# YOU RAN OUT OF BATTERY  /  YOU TOOK A BAD PICTURE
	# SCORE: 123123123
	# THANKS FOR PLAYING
	# TODO: Score
	# TODO: Wilhelm scream

func take_screenshot() -> Image:
	var img := get_viewport().get_texture().get_image()
	# img.flip_y() # Tarvitaan usein, koska kuvat saattavat olla ylösalaisin
	return img


func get_string_from_noise(noise) -> String:
	if noise > 40:
		return("TERRIBLE")
	elif noise > 8:
		return("BAD")
	elif noise > 6:
		return("MEH")
	elif noise > 4:
		return("OK")
	elif noise > 2:
		return("GOOD")
	else:
		return("EXCELLENT")
