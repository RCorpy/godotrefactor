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
var maxHealth = 10
var health = 10
var towerHealing = 0
var defense = 0 

func getDefense():
	defense = data_store.Sheppard.level - 1
	return defense

func getPower():
	power = data_store.KnightHouse.level
	return power

func getRanged():
	ranged = data_store.KnightHouse2.level - 1
	return ranged	

func getTowerHealing():
	towerHealing = data_store.Tower.level - 1
	return towerHealing

func modifyHealth(plus, minus):
	health = health + plus - minus
	if health > maxHealth:
		health = maxHealth
	return health


#enemies

var currentEnemy = {
	"power": 15,
	"health": 30,
	"sprite": "none",
	"reward": 400
}

func getEnemyReward():
	return round * 20

func createEnemy():
	currentEnemy = {
		"power": round * 1,
		"health": round * 2,
		"sprite": "none",
		"reward": getEnemyReward()
	}
	
	return {
		"power": round * 1,
		"health": round * 2,
		"sprite": "none",
		"reward": getEnemyReward()
	}

func adjustForRangedPower():
	currentEnemy.health = currentEnemy.health * (1 - 0.1*getRanged())

func _on_combat_timer_timeout():
	#print player stats
	rewriteStats()
	
	#player attack
	currentEnemy.health -= getPower()
	#enemy attack
	modifyHealth(0, currentEnemy.power - getDefense())
	
	#check for end of combat
	#player death
	if health<1:
		combat_timer.stop()
		rewriteStats()
		emit_signal("game_over")
		failure.visible = true
		continue_button.visible = false
		visible = false
		$"../Menu".hide_menu()
	#enemy death
	elif currentEnemy.health <1:
		combat_timer.stop()
		rewriteStats()
		emit_signal("victory", currentEnemy.reward)
		success.visible = true
		continue_button.visible = true
		$FireSprite.visible = true
		$EnemySprite.visible = false
		return "Victory"
	else:
		# combat turn
		rewriteStats()
		startTimer()

func startTimer():
	combat_timer.start(1.0)


func _on_continue_button_pressed():
	$"..".movementDisabled = false
	$FireSprite.visible = false
	$EnemySprite.visible = true
	failure.visible = false
	success.visible = false
	continue_button.visible = false
	$"../Menu".hide_menu()
	visible = false
	if failure.visible == true:
		print("defeated")
	else:
		round = round + 1
		modifyHealth(getTowerHealing(),0)
		print("victorious")
		
func rewriteStats():
	control_player.text = "%s: %d
%s: %d" % [tr("power"),getPower(),tr("health"), health]
	control_enemy.text = "%s: %d
%s: %d" % [tr("power"), currentEnemy.power - getDefense(),tr("health"),currentEnemy.health]
