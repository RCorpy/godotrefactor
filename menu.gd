extends Area2D

@onready var data_store = %DataStore
@onready var fight = $"../Fight"
@onready var center_center = $CenterCenter
@onready var right_center = $RightCenter
@onready var right_side_text = $RightSideText

var richTextNode = preload("res://rich_text.tscn")
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
	for n in get_node("CenterCenter").get_children():
		get_node("CenterCenter").remove_child(n)
	for n in get_node("RightCenter").get_children():
		get_node("RightCenter").remove_child(n)

func updateMiddlePart(nameOfNode):
	if nameOfNode == "Castle":
		get_node("NextWaveButton").visible = true
		get_node("NextWaveButton").text = tr("nextwave")
		var abovetext = RichTextLabel.new()
		abovetext.size = Vector2(200, 40)
		abovetext.position = position + Vector2(-78,-65)
		abovetext.bbcode_enabled=true
		abovetext.set_cell_border_color("black")
		abovetext.text = "[center]"+ tr("castleabovecontinue") + str($"../Fight".round)
		center_center.add_child(abovetext)
		var belowtext = RichTextLabel.new()
		belowtext.size = Vector2(200, 40)
		belowtext.position = position  + Vector2(-78,42)
		belowtext.bbcode_enabled=true
		belowtext.set_cell_border_color("black")
		belowtext.text = "[center]"+ tr("castlebelowcontinue") + str($"../Fight".getEnemyReward())
		center_center.add_child(belowtext)
	else:
		get_node("NextWaveButton").visible = false
	
func updateRightPart(nameOfNode):
	if nameOfNode == "Castle":
		right_side_text.text = "[center]" +tr("rightcastletext")
	else:
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
	$"..".movementDisabled = true
	fight.visible= true
	fight.createEnemy()
	fight.adjustForRangedPower()
	$"../../Mine".mineWork()
	fight.startTimer()
	fight.rewriteStats()


func _on_mine_show_menu(boolean, nameOfNode):
	#(nameOfNode)
	data_store.currentBuilding = nameOfNode
	if boolean:
		leftSideSprite = data_store.getCurrentSprite().instantiate()
		get_node("LeftCenter").add_child(leftSideSprite)
		updateMiddlePart(nameOfNode)
		updateRightPart(nameOfNode)
		show_menu()
		#(boolean)
	else:
		hide_menu()
