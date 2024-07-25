extends Node2D

var save_path = "user://psudohero.save"
var stored_data

func save_data(data):
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(data)
	print("saved!")
	print("castle level :" + str(data.Castle))
	
func load_data():

	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		stored_data = file.get_var()
		return stored_data
	else:
		print("no data saved...")
		return null
