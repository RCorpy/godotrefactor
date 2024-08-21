extends Node2D

@onready var data_store = %DataStore
@onready var save_manager = $"../SaveManager"
@onready var root = $".."

signal do_save()
signal do_load(data)

func on_save():
	emit_signal("do_save")
	#save_manager.save_data(data_store.get_all_data())
	
func on_load():
	emit_signal("do_load", "hello")
	#if save_manager.load_data():
		#data_store.load_all_data(save_manager.load_data())

func use_game_camera():
	$Player.use_this_camera()

func change_language(language):
	$Language.change_language(language)
	
func start_welcome():
	#$Player/PopUp.closePopUp()
	$Player/PopUp.visible = false
	if $Player/Fight.round ==1:
		$Player/PopUp.openPopUp("start","","start2")


