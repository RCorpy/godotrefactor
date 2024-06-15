extends StaticBody2D

const GoldMineOnSprite = preload("res://sprites/GoldMineOn.png")
const GoldMineOffSprite = preload("res://sprites/GoldMineOff.png")

func _on_mine_interact_body_entered(body):
	if(body.get_name()=="Player"):
		get_node("MineSprite").texture = GoldMineOnSprite


func _on_mine_interact_body_exited(body):
	if(body.get_name()=="Player"):
		get_node("MineSprite").texture = GoldMineOffSprite
