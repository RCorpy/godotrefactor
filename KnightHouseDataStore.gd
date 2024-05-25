extends Node2D

const data = "myData"

#idle, upgrading, readyToComplete
var status = "idle"

var level = 0
var maxLevel = 4
var upgradeTimes = [3,7, 15, 18]

const FOUNDATIONSPRITE = preload("res://sprites/House_Construction.png")
const LOWLEVELHOUSE = preload("res://sprites/Goblin_House.png")
const HIGHLEVELHOUSE = preload("res://sprites/House_Blue.png")


