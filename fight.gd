extends Node2D

@onready var data_store = %DataStore


#player stats
var power = 0
var ranged = 0
var health = 0
var towerHealing = 0

func getPower():
	power = data_store.KnightHouse.level
	return power

func getRanged():
	ranged = data_store.KnightHouse2.level
	return ranged	

func getTowerHealing():
	towerHealing = data_store.Tower.level
	return towerHealing

func modifyHealth(plus, minus):
	health = health + plus - minus
	return health


#enemies

var round1 = {
	"power": 1,
	"health": 2,
	"sprite": "none",
	"reward": 100
}
