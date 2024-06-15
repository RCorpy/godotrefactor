extends Node2D

var currentBuilding = "KnightHouse"

const KnightSprite = preload("res://knight_sprite.tscn")
const ArcherSprite = preload("res://archer_sprite.tscn")

#for Houses

#Knight House


const FOUNDATIONSPRITE = preload("res://sprites/House_Construction.png")
const LOWLEVELHOUSE = preload("res://sprites/Goblin_House.png")
const HIGHLEVELHOUSE = preload("res://sprites/House_Blue.png")



var KnightHouse = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 4,
	"upgradeTimes": [3,7, 15, 18],
	"sprites": [FOUNDATIONSPRITE, LOWLEVELHOUSE, LOWLEVELHOUSE, HIGHLEVELHOUSE, HIGHLEVELHOUSE]
}

var KnightHouse2 = {
	"status": "idle",
	"progressValue": 0,
	"level" : 1,
	"maxLevel": 2,
	"upgradeTimes": [3,7],
	"sprites": [FOUNDATIONSPRITE, HIGHLEVELHOUSE]
}



#Archer House

var ArcherHouseVars = {
	"maxLevel": 4,
	"upgradeTimes": [3,7, 15, 18]
}

#for Menu
func getCurrentSprite():
	match currentBuilding:
		"KnightHouse":
			return KnightSprite
		"ArcherHouse":
			return ArcherSprite
		"KnightHouse2":
			return ArcherSprite
		_:
			return KnightSprite
