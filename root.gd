extends Node2D

@onready var main = $Main
@onready var start_menu = $StartMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	activate_menu_camera()

func activate_menu_camera():
	start_menu.use_start_menu_camera()
	main.visible = false
	start_menu.visible = true

func activate_game_camera():
	main.use_game_camera()
	main.visible = true
	start_menu.visible = false
	main.start_welcome()
	
# Game Over
# Save / Load Functions
# Improve Menu
# Music

