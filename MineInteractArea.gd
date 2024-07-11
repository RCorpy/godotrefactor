extends CollisionShape2D

@onready var knight_house_data_store = %KnightHouseDataStore


signal create_pop_up
signal remove_pop_up



func _on_knight_house_body_entered(body):
	if body.has_method("_input"):
		#get Specific data if not yet retrieved
		create_pop_up.emit()
		
		




func _on_knight_house_interact_body_exited(body):
	if body.has_method("_input"):
		remove_pop_up.emit()
