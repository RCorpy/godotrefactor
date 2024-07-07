extends Node2D

@onready var ControlUi = %ControlUI

var isMining= false
var Ore = 0
var currentBuilding = "KnightHouse"

const KnightSprite = preload("res://knight_sprite.tscn")
const ArcherSprite = preload("res://archer_sprite.tscn")
const CastleSprite = preload("res://CastleSprite.tscn")
const TowerSprite = preload("res://TowerSprite.tscn")
const SheppardSprite = preload("res://ShepperdSprite.tscn")

#for Houses

#Knight House


const FOUNDATIONSPRITE = preload("res://sprites/House_Construction.png")
const LOWLEVELHOUSE = preload("res://sprites/Goblin_House.png")
const HIGHLEVELHOUSE = preload("res://sprites/House_Blue.png")

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

var KnightHouse = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 4,
	"upgradeTimes": [3,7, 15, 18],
	"orePrice": [5,10,15,20],
	"sprites": [FOUNDATIONSPRITE, LOWLEVELHOUSE, LOWLEVELHOUSE, HIGHLEVELHOUSE, HIGHLEVELHOUSE]
}

var Mine = {
	"level": 4,
	"upgradeTimes": [5,10,15],
	"orePrice": [5,10,15],
	"maxLevel": 3
}

var KnightHouse2 = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 2,
	"upgradeTimes": [3,7],
	"orePrice": [15,20],
	"sprites": [FOUNDATIONSPRITE, HIGHLEVELHOUSE]
}

var Castle = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 5,
	"upgradeTimes": [3,7,3,3,3],
	"orePrice": [15,20,3,3,3],
	"sprites": [CASTLEFOUNDATION, CASTLEBLUE, CASTLEPURPLE, CASTLEYELLOW, CASTLERED]
}

var Tower = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 2,
	"upgradeTimes": [3,7],
	"orePrice": [15,20],
	"sprites": [TOWERFOUNDATION, TOWERBLUE]
}

var Sheppard = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 2,
	"upgradeTimes": [3,7],
	"orePrice": [15,20],
	"sprites": [FOUNDATIONSPRITE, HIGHLEVELHOUSE]
}

#Archer House

var ArcherHouse = {
	"maxLevel": 4,
	"upgradeTimes": [3,7, 15, 18]
}

func getVariable(variable):
	match variable:
		"KnightHouse":
			return KnightHouse
		"ArcherHouse":
			return ArcherHouse
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





	
