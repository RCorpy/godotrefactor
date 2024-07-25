extends Node2D

@onready var data_store = %DataStore
@onready var save_manager = $"../SaveManager"

func on_save():
	save_manager.save_data(data_store.get_all_data())
	
func on_load():
	if save_manager.load_data():
		data_store.load_all_data(save_manager.load_data())
