extends Area2D

@onready var data_store = %DataStore
@onready var fight = $"../Fight"

var leftSideSprite = ""
var middleMenu=""
var rightMenu=""
var initial_position = Vector2(0,0)

func show_menu():
	position += Vector2(0,-200)
	

func hide_menu():
	position = initial_position
	for n in get_node("LeftCenter").get_children():
		get_node("LeftCenter").remove_child(n)
	

func updateMiddlePart(nameOfNode):
	if nameOfNode == "Castle":
		get_node("NextWaveButton").visible = true
		
	else:
		get_node("NextWaveButton").visible = false
	
func updateRightPart(nameOfNode):
	pass

func _on_knight_house_show_menu(boolean, nameOfNode):
	print(nameOfNode)
	data_store.currentBuilding = nameOfNode
	if boolean:
		leftSideSprite = data_store.getCurrentSprite().instantiate()
		get_node("LeftCenter").add_child(leftSideSprite)
		updateMiddlePart(nameOfNode)
		updateRightPart(nameOfNode)
		show_menu()
		print(boolean)
	else:
		hide_menu()



func _on_ready():
	initial_position = position



func _on_next_wave_button_pressed():
	fight.visible= true
	fight.createEnemy()
	fight.adjustForRangedPower()
	$"../../Mine".mineWork()
	fight.startTimer()
	fight.rewriteStats()


func _on_mine_show_menu(boolean, nameOfNode):
	print(nameOfNode)
	data_store.currentBuilding = nameOfNode
	if boolean:
		leftSideSprite = data_store.getCurrentSprite().instantiate()
		get_node("LeftCenter").add_child(leftSideSprite)
		updateMiddlePart(nameOfNode)
		updateRightPart(nameOfNode)
		show_menu()
		print(boolean)
	else:
		hide_menu()
