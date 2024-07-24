extends Area2D

@onready var data_store = %DataStore
@onready var fight = $"../Fight"
@onready var center_center = $CenterCenter
@onready var right_center = $RightCenter
@onready var right_side_text = $RightSideText
@onready var center_side_text = $CenterSideText

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
		center_side_text.visible= false
		get_node("NextWaveButton").visible = true
		get_node("NextWaveButton").text = tr("nextwave")
		var abovetext = RichTextLabel.new()
		abovetext.size = Vector2(300, 40)
		abovetext.position = position + Vector2(-128,-65)
		abovetext.bbcode_enabled=true
		abovetext.set_cell_border_color("black")
		abovetext.text = "[center][color=#000000]"+ tr("castleabovecontinue") + str($"../Fight".round) + "   " + tr("castlebelowcontinue") + str($"../Fight".getEnemyReward())
		center_center.add_child(abovetext)
		var belowtext = RichTextLabel.new()
		belowtext.size = Vector2(200, 40)
		belowtext.position = position  + Vector2(-78,42)
		belowtext.bbcode_enabled=true
		belowtext.set_cell_border_color("black")
		belowtext.text = "[center][color=#000000]"+ tr("improvementcost")+ str(data_store.KnightHouse.orePrice[data_store.KnightHouse.level-1])
		center_center.add_child(belowtext)
	else:
		get_node("NextWaveButton").visible = false
		center_side_text.visible = true
		if nameOfNode == "KnightHouse":
			center_side_text.text = "[center][color=#000000][font_size=28]" +tr("middleknighthousetext") + " " + str(data_store.KnightHouse.level) + "[font_size=18]\n" + tr("improvementcost") + str(data_store.KnightHouse.orePrice[data_store.KnightHouse.level-1])
		if nameOfNode == "KnightHouse2":
			center_side_text.text = "[center][color=#000000][font_size=28]" +tr("middlearcherhousetext") + str(data_store.KnightHouse2.level -1)+"%" + "[font_size=18]\n" + tr("improvementcost")+ str(data_store.KnightHouse2.orePrice[data_store.KnightHouse2.level-1])
		if nameOfNode == "Mine":
			center_side_text.text = "[center][color=#000000][font_size=28]" +tr("middleminetext") +str(data_store.Mine.level -1) + "[font_size=18]\n" + tr("improvementcost") + str(data_store.Mine.orePrice[data_store.Mine.level-1])
		if nameOfNode == "Tower":
			center_side_text.text = "[center][color=#000000][font_size=28]" +tr("middletowertext") + " " + str(data_store.Tower.level -1) + "[font_size=18]\n" + tr("improvementcost") + str(data_store.Tower.orePrice[data_store.Tower.level-1])
		if nameOfNode == "Sheppard":
			center_side_text.text = "[center][color=#000000][font_size=28]" +tr("middlesheppardtext") + " " + str(data_store.Sheppard.level -1) + "[font_size=18]\n" + tr("improvementcost") + str(data_store.Sheppard.orePrice[data_store.Sheppard.level-1])
	
	
func updateRightPart(nameOfNode):
	if nameOfNode == "Castle":
		right_side_text.text = "[center]" +tr("rightcastletext") + str(data_store.Castle.level-1)
	if nameOfNode == "KnightHouse":
		right_side_text.text = "[center]" +tr("rightknighthousetext") 
	if nameOfNode == "KnightHouse2":
		right_side_text.text = "[center]" +tr("rightarcherhousetext")
	if nameOfNode == "Mine":
		right_side_text.text = "[center]" +tr("rightminetext")
	if nameOfNode == "Tower":
		right_side_text.text = "[center]" +tr("righttowertext")
	if nameOfNode == "Sheppard":
		right_side_text.text = "[center]" +tr("rightsheppardtext")
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
