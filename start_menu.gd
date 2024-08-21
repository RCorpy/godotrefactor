extends Node2D

@onready var root = $".."
@onready var main = $"../Main"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func use_start_menu_camera():
	$Camera2D.make_current()


func _on_start_button_pressed():
	root.activate_game_camera()


func _on_espanol_button_pressed():
	main.change_language("es")
	translate_to("es")


func _on_english_button_pressed():
	main.change_language("en")
	translate_to("en")
	
func translate_to(lang):
	if lang == "en":
		$Area2D/StartButton.text = "Start"
		$Area2D/LoadButton.text = "Load"
		
	if lang == "es":
		$Area2D/StartButton.text = "Empezar"
		$Area2D/LoadButton.text = "Cargar"

func delete_save():
	print("Save was deleted")
	pass
