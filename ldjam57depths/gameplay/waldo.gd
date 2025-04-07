extends Node2D


func _ready():
	SIGNAL_BUS.picture_taken.connect(_on_picture_taken)


func _on_picture_taken():
	var picture_noise = $"../Sprite".material.get_shader_parameter("strength")
	var points = get_exponential_points(picture_noise)
	print("POINTS: ", points)
	SIGNAL_BUS.add_score.emit(points, picture_noise)
	if picture_noise > 40:
		SIGNAL_BUS.game_over.emit("YOU TOOK A BAD PICTURE")


func get_exponential_points(rating: int, max_points: int = 10000, alpha: float = .4) -> int:
	# Käytetään kaavaa:
	# points = max_points * (exp(-alpha * rating) - exp(-alpha * 40)) / (1 - exp(-alpha * 40))
	# Kun rating = 0: 
	#   numerator = exp(0) - exp(-alpha * 40) = 1 - exp(-alpha * 40)
	#   denominator = 1 - exp(-alpha * 40)
	#   => points = max_points
	# Kun rating = 40:
	#   numerator = exp(-alpha * 40) - exp(-alpha * 40) = 0
	#   => points = 0
	var numerator = exp(-alpha * rating) - exp(-alpha * 40)
	var denominator = 1 - exp(-alpha * 40)
	return int(max_points * numerator / denominator)
