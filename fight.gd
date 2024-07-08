extends Node2D

@onready var data_store = %DataStore
@onready var combat_timer = $CombatTimer
@onready var success = $Victory
@onready var failure = $Defeat
@onready var continue_button = $ContinueButton
@onready var control_player = $ControlPlayer
@onready var control_enemy = $ControlEnemy

signal victory(reward)
signal game_over

var round = 1

#player stats
var power = 0
var ranged = 0
var health = 10
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

var enemies = [
	#enemy 1
	{
	"power": 1,
	"health": 2,
	"sprite": "none",
	"reward": 100
},
#enemy 2
	{
	"power": 2,
	"health": 4,
	"sprite": "none",
	"reward": 200
},
#enemy 3
	{
	"power": 4,
	"health": 8,
	"sprite": "none",
	"reward": 400
},
]


func _on_combat_timer_timeout():
	#print player stats
	rewriteStats()
	
	#player attack
	enemies[round-1].health -= getPower()
	#enemy attack
	modifyHealth(0, enemies[round-1].power)
	
	#check for end of combat
	#player death
	if health<1:
		combat_timer.stop()
		rewriteStats()
		emit_signal("game_over")
		failure.visible = true
		continue_button.visible = true
		return "Game Over"
	#enemy death
	elif enemies[round-1].health <1:
		combat_timer.stop()
		rewriteStats()
		emit_signal("victory", enemies[round-1].reward)
		success.visible = true
		continue_button.visible = true
		return "Victory"
	else:
		print("combat turn")
		rewriteStats()
		startTimer()

func startTimer():
	combat_timer.start(1.0)


func _on_continue_button_pressed():
	if failure.visible == true:
		failure.visible = false
		success.visible = false
		visible = false
		print("defeated")
	else:
		failure.visible = false
		success.visible = false
		visible = false
		round = round + 1
		print("victorious")
		
func rewriteStats():
	control_player.text = "Power: %d
Health: %d" % [getPower(), health]
	control_enemy.text = "Power: %d
Health: %d" % [enemies[round-1].power, enemies[round-1].health]
