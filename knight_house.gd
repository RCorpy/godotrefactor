extends StaticBody2D

signal create_something
@onready var knight_house_data_store = %KnightHouseDataStore


func _on_knight_house_interact_area_create_pop_up():
	print(knight_house_data_store.data)
