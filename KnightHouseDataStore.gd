extends Node2D

#const data = "myData"
signal getHouseData

#idle, upgrading, readyToComplete

var updated = false

var status = "idle"
var level = 1
var maxLevel = 4
var upgradeTimes = [3,7, 15, 18]
var progressValue = 0
var sprites = []

const FOUNDATIONSPRITE = preload("res://sprites/House_Construction.png")
const LOWLEVELHOUSE = preload("res://sprites/Goblin_House.png")
const HIGHLEVELHOUSE = preload("res://sprites/House_Blue.png")




func get_data_ready():
	getHouseData.emit(get_parent().get_name())
	updated = true
