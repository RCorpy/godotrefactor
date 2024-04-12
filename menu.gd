extends Area2D

@onready var data_store = %DataStore

var leftSideSprite = ""
var initial_position = Vector2(0,0)

func show_menu():
	position += Vector2(0,-200)
	

func hide_menu():
	position = initial_position
	for n in get_node("LeftCenter").get_children():
		get_node("LeftCenter").remove_child(n)
	


func _on_knight_house_show_menu(boolean):
	if boolean:
		leftSideSprite = data_store.KnightSprite.instantiate()
		get_node("LeftCenter").add_child(leftSideSprite)
		show_menu()
		print(boolean)
	else:
		hide_menu()



func _on_ready():
	initial_position = position
