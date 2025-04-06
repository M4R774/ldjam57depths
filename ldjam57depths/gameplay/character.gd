extends Node2D

# Määritellään liikkumisalue (Rect2: sijainti ja koko)
var area_rect: Rect2 = Rect2(Vector2(0, -1000), Vector2(2200, 1700))

# Liikkumiseen liittyvät muuttujat
var target_pos: Vector2
var speed: float = 100.0  # Liikkumisnopeus

# Syvyysanimaation parametrit: suurempi skaala alhaalla ruudulla
var max_scale: float = 2.0  # Isin skaala, kun hahmo on ruudun alareunassa
var min_scale: float = 0.3  # Pienin skaala, kun hahmo on ruudun yläreunassa

# Alueen y-koordinaatit skaalauksen laskemiseen
var y_min: float = area_rect.position.y
var y_max: float = area_rect.position.y + area_rect.size.y

func _ready():
	randomize()  # Varmistetaan satunnaisuuden toimivuus
	set_random_target()

func _process(delta):
	# Liikutetaan hahmoa kohti kohdepaikkaa
	var direction = (target_pos - position).normalized()
	position += direction * speed * delta

	# Kun hahmo on lähellä kohdetta, valitaan uusi satunnainen kohde
	if position.distance_to(target_pos) < 10:
		set_random_target()

	# Päivitetään skaalauksen syvyysanimaatio y-koordinaatin mukaan
	update_scale()
	var distance_from_camera = map_range(position.y, y_min, y_max, 100, 0)
	$Sprite.change_distance_from_camera(distance_from_camera)


func map_range(value: float, low1: float, high1: float, low2: float, high2: float) -> float:
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)


# Skaalataan hahmo niin, että ruudun yläreunassa (kauempana) on pienempi skaala
# ja alareunassa (lähempänä) suurempi skaala.
func update_scale():
	var t = (position.y - y_min) / (y_max - y_min)
	var scale_factor = lerp(min_scale, max_scale, t)
	scale = Vector2(scale_factor, scale_factor)

# Asettaa uuden satunnaisen kohdepisteen määritellyn alueen sisällä
func set_random_target():
	var rand_x = randf_range(area_rect.position.x, area_rect.position.x + area_rect.size.x)
	var rand_y = randf_range(area_rect.position.y, area_rect.position.y + area_rect.size.y)
	target_pos = Vector2(rand_x, rand_y)
