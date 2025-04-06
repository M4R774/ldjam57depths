extends MenuButton

@onready var popup_menu = get_popup()


func _ready():
	# Lisää valintoja ohjelmallisesti (tai käytä editoria)
	popup_menu.clear()
	popup_menu.add_item("Main Menu", 0)
	popup_menu.id_pressed.connect(_on_menu_item_selected)


func _on_menu_item_selected(id):
	var valittu = popup_menu.get_item_text(id)
	print("Valittu:", valittu)
	match valittu:
		"Main Menu":
			get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
		_:
			print("Tuntematon valinta:", valittu)
