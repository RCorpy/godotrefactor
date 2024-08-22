extends Node2D

@onready var start_menu = $"../StartMenu"
@onready var main = $"../Main"

func on_game_over_start():
	get_game_over_translations()
	visible = true
	position = main.get_node("Player").position

func on_game_over_close():

	#delete save
	start_menu.delete_save()
	#go to menu
	start_menu.use_start_menu_camera()
	start_menu.visible = true
	main.visible = false
	visible = false
	

func _on_button_pressed():
	on_game_over_close()
	

func get_game_over_translations():
	$Area2D/Button.text = tr("go agane")
	$Area2D/RichTextLabel.text =  "[center]"+ tr("defeat")
	$Area2D/RichTextLabel2.text = "[center]"+ tr("at wave") + str(main.get_node("Player").get_node("Fight").round)
