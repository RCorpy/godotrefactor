extends StaticBody2D
@onready var globalDataStore = %DataStore

const GoldMineOnSprite = preload("res://sprites/GoldMineOn.png")
const GoldMineOffSprite = preload("res://sprites/GoldMineOff.png")
@onready var plus_banner = $MineDataStore/PlusBanner
@onready var complete_banner = $MineDataStore/CompleteBanner
@onready var progress_bar = $MineDataStore/ProgressBar

signal show_menu
signal startMining
signal stopMining



var thisData


func mineWork():
	%DataStore.Ore = %DataStore.Ore + %DataStore.Mine.level * 10

func _on_mine_interact_body_entered(body):
	if(body.get_name()=="Player"):
		get_node("MineSprite").texture = GoldMineOnSprite
		#startMining.emit() <-- we dont mine anymore
		#get Specific data if not yet retrieved
		on_mine_create_pop_up()


func _on_mine_interact_body_exited(body):
	if(body.get_name()=="Player"):
		get_node("MineSprite").texture = GoldMineOffSprite
		#stopMining.emit() <-- we dont mine anymore
		on_mine_remove_pop_up()


###copied from knighthouse###

func check_upgrade_req():
	#Do you have the castle level?
	print("castle level" + str(globalDataStore.Castle.level) + str(globalDataStore.checkBuiltBuildings())+ str(globalDataStore.Castle.level <= globalDataStore.checkBuiltBuildings()))
	print("resources" + str(globalDataStore.Ore >= thisData.orePrice[thisData.level - 1]))
	if get_name() == "Castle" || globalDataStore[get_name()].level > 1:
		print("its castle, ignore castle level req")
	elif globalDataStore.Castle.level - 1 <= globalDataStore.checkBuiltBuildings():
		print("ERROR, you dont have castle level")
		return false
	#Are there resources?
	if globalDataStore.Ore >= thisData.orePrice[thisData.level - 1]:
		globalDataStore.Ore -= thisData.orePrice[thisData.level - 1]
		globalDataStore.updateControlUi()
		return true
	else:
		#Need to show message when you dont have Ore
		print("ERROR, you dont have ore")
		return false

func on_mine_create_pop_up():
	
	show_menu.emit(true, get_name())
	## if there is nothing going on (idle) -> show me the upgrade button
	
	if thisData.status == "idle" && thisData.level < thisData.maxLevel:
		plus_banner.process_mode = Node.PROCESS_MODE_INHERIT
		plus_banner.get_node("BannerHorizontal").visible = true
		plus_banner.get_node("PlusSign").visible = true

	

func on_mine_remove_pop_up():
	plus_banner.process_mode = Node.PROCESS_MODE_DISABLED
	plus_banner.get_node("BannerHorizontal").visible = false
	plus_banner.get_node("PlusSign").visible = false
	show_menu.emit(false, get_name())


#Upgrade sequence



func get_progress_bar(UpgradeToLevel):
	if UpgradeToLevel >0:
		#start progress bar with a timer depending on level
		progress_bar.start(thisData.upgradeTimes[UpgradeToLevel-1])

	



func _on_complete_banner_complete_sign_clicked():
		#remove completed banner
	complete_banner.get_node("BannerHorizontal").visible = false
	complete_banner.get_node("CompleteSign").visible = false
	complete_banner.process_mode = Node.PROCESS_MODE_DISABLED
	
	#increase level
	thisData.level +=1
	
	#set status to idle to allow to be upgraded again
	thisData.status = "idle"
	

	#change texture of house
	
	get_node("MineSprite").texture = thisData.sprites[thisData.level-1]

	


func _on_ready():
	thisData = globalDataStore[get_name()]
	
	print(thisData)


func _on_plus_banner_plus_sign_clicked():
	if check_upgrade_req():
		thisData.status = "upgrading"
		print("upgrading to: " + str(thisData.level+1))
		get_progress_bar(thisData.level+1)





func _on_progress_bar_finished_bar():
		#remove progress bar
	progress_bar.visible = false
	
	
	#create a completed popup
	complete_banner.get_node("BannerHorizontal").visible = true
	complete_banner.get_node("CompleteSign").visible = true
	complete_banner.process_mode = Node.PROCESS_MODE_INHERIT
	
	#when popup is clicked
	#_on_complete_banner_complete_sign_clicked()

