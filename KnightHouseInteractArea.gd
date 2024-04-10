extends CollisionShape2D

@onready var knight_house_data_store = %KnightHouseDataStore
@onready var plus_banner = %PlusBanner

signal create_pop_up

func _on_knight_house_body_entered(body):
	if body.has_method("_input"):
		print("yes?")
		create_pop_up.emit()


