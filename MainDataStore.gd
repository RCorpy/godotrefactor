extends Node2D

@onready var ControlUi = %ControlUI


var isMining= false
var Ore = 0
var currentBuilding = "KnightHouse"
var builtBuildings = 0

const KnightSprite = preload("res://knight_sprite.tscn")
const ArcherSprite = preload("res://archer_sprite.tscn")
const CastleSprite = preload("res://CastleSprite.tscn")
const TowerSprite = preload("res://TowerSprite.tscn")
const SheppardSprite = preload("res://ShepperdSprite.tscn")

#for Houses

#Knight House


const FOUNDATIONSPRITE = preload("res://sprites/House_Construction.png")
const LOWLEVELHOUSE = preload("res://sprites/Goblin_House.png")
const HOUSEBLUE = preload("res://sprites/House_Blue.png")
const HOUSEYELLOW = preload("res://sprites/House_Yellow.png")
const HOUSERED = preload("res://sprites/House_Red.png")
const HOUSEPURPLE = preload("res://sprites/House_Purple.png")

const CASTLEFOUNDATION = preload("res://sprites/castlebase.png")
const CASTLEPURPLE = preload("res://sprites/castlepurple.png")
const CASTLEYELLOW = preload("res://sprites/castleyellow.png")
const CASTLERED = preload("res://sprites/castlered.png")
const CASTLEBLUE = preload("res://sprites/castleblue.png")

const TOWERFOUNDATION = preload("res://sprites/TowerFoundation.png")
const TOWERPURPLE = preload("res://sprites/TowerPurple.png")
const TOWERYELLOW = preload("res://sprites/TowerYellow.png")
const TOWERRED = preload("res://sprites/TowerRed.png")
const TOWERBLUE = preload("res://sprites/TowerBlue.png")

const WOODTOWERFOUNDATION = preload("res://sprites/WoodTowerFoundation.png")
const WOODTOWERBLUE = preload("res://WoodTowerBlueSprite.tscn")

const MINESPRITE = preload("res://mine_animated_sprite.tscn")

var KnightHouse = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 9,
	"upgradeTimes": [5,5,5,5,5,5,5,5,5],
	"orePrice": [5,10,15,20,25,30,35,40,45],
	"sprites": [FOUNDATIONSPRITE, LOWLEVELHOUSE, LOWLEVELHOUSE, HOUSEBLUE, HOUSEBLUE, HOUSERED, HOUSERED, HOUSEPURPLE, HOUSEYELLOW]
}

var Mine = {
	"status": "idle",
	"progressValue": 0,
	"level": 1,
	"maxLevel": 9,
	"upgradeTimes": [5,5,5,5,5,5,5,5,5],
	"orePrice": [5,10,15,20,25,30,35,40,45],
	"sprites": [MINESPRITE, MINESPRITE, MINESPRITE, MINESPRITE, MINESPRITE, MINESPRITE, MINESPRITE, MINESPRITE, MINESPRITE]
}

var KnightHouse2 = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 9,
	"upgradeTimes": [5,5,5,5,5,5,5,5,5],
	"orePrice": [5,10,15,20,25,30,35,40,45],
	"sprites": [FOUNDATIONSPRITE, LOWLEVELHOUSE, LOWLEVELHOUSE, HOUSEBLUE, HOUSEBLUE, HOUSERED, HOUSERED, HOUSEPURPLE, HOUSEYELLOW]
}

var Castle = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 6,
	"upgradeTimes": [5,5,5,5,5, 5],
	"orePrice": [5,10,15,20,25,30],
	"sprites": [CASTLEFOUNDATION, CASTLEBLUE, CASTLERED, CASTLERED, CASTLEPURPLE, CASTLEYELLOW]
}

var Tower = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 9,
	"upgradeTimes": [5,5,5,5,5,5,5,5,5],
	"orePrice": [5,10,15,20,25,30,35,40,45],
	"sprites": [TOWERFOUNDATION, TOWERBLUE, TOWERBLUE, TOWERRED, TOWERRED, TOWERPURPLE, TOWERPURPLE, TOWERYELLOW, TOWERYELLOW]
}

var Sheppard = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 9,
	"upgradeTimes": [5,5,5,5,5,5,5,5,5],
	"orePrice": [5,10,15,20,25,30,35,40,45],
	"sprites": [FOUNDATIONSPRITE, LOWLEVELHOUSE, LOWLEVELHOUSE, HOUSEBLUE, HOUSEBLUE, HOUSERED, HOUSERED, HOUSEPURPLE, HOUSEYELLOW]
}


func getVariable(variable):
	match variable:
		"KnightHouse":
			return KnightHouse
		"KnightHouse2":
			return KnightHouse2
		"Castle":
			return Castle
		"Tower":
			return Tower
		"Mine":
			return Mine
		"Sheppard":
			return Sheppard
		_:
			return KnightSprite

#for Menu
func getCurrentSprite():
	match currentBuilding:
		"KnightHouse":
			return KnightSprite
		"ArcherHouse":
			return ArcherSprite
		"KnightHouse2":
			return ArcherSprite
		"Castle":
			return CastleSprite
		"Tower":
			return TowerSprite
		"Sheppard":
			return SheppardSprite
		"Mine":
			return MINESPRITE
		_:
			return KnightSprite

#Upgrade functions

func check_upgrade_req(node_name):
	print(str(getVariable(node_name).level) + "this is current level")
	
#For mining

func _on_mine_start_mining():
	isMining = true

func _on_mine_stop_mining():
	isMining = false

func _process(delta):
	if isMining:
		Ore += delta * Mine["level"]
		ControlUi.text = str(round(Ore)) + " Ore"
		
func updateControlUi():
	ControlUi.text = str(round(Ore)) + " Ore"

func _on_fight_victory(reward):
	Ore = Ore + reward
	updateControlUi()

func _on_fight_game_over():
	pass # Replace with function body.
	
func checkBuiltBuildings():
	builtBuildings = 0
	if KnightHouse.level >1:
		builtBuildings = builtBuildings + 1
	if KnightHouse2.level >1:
		builtBuildings = builtBuildings + 1
	if Sheppard.level >1:
		builtBuildings = builtBuildings + 1
	if Tower.level >1:
		builtBuildings = builtBuildings + 1
	if Mine.level >1:
		builtBuildings = builtBuildings + 1
	
	return builtBuildings
