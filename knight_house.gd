extends StaticBody2D

signal show_menu

#@onready var thisData = %KnightHouseDataStore
@onready var plus_banner = %PlusBanner
@onready var complete_banner = %CompleteBanner
@onready var progress_bar= %ProgressBar
@onready var globalDataStore = $"../DataStore"
@onready var pop_up = $"../Player/PopUp"

var thisData


func check_upgrade_req():
	#Do you have the castle level?
	if get_name() == "Castle" || globalDataStore[get_name()].level > 1:
		print("its castle, ignore castle level req")
	elif globalDataStore.Castle.level - 1 <= globalDataStore.checkBuiltBuildings():
		print("ERROR, you dont have castle level")
		pop_up.openPopUp("oops","errorcastlelevel")
		return false
	#Are there resources?
	if globalDataStore.Ore >= thisData.orePrice[thisData.level - 1]:
		globalDataStore.Ore -= thisData.orePrice[thisData.level - 1]
		globalDataStore.updateControlUi()
		return true
	else:
		#Need to show message when you dont have Ore
		print("ERROR, you dont have ore")
		pop_up.openPopUp("oops","errororeamount")
		return false


func _on_knight_house_interact_area_create_pop_up():
	
	show_menu.emit(true, get_name())
	## if there is nothing going on (idle) -> show me the upgrade button
	
	if thisData.status == "idle" && thisData.level < thisData.maxLevel:
		plus_banner.process_mode = Node.PROCESS_MODE_INHERIT
		plus_banner.get_node("BannerHorizontal").visible = true
		plus_banner.get_node("PlusSign").visible = true

	

func _on_knight_house_interact_area_remove_pop_up():
	plus_banner.process_mode = Node.PROCESS_MODE_DISABLED
	plus_banner.get_node("BannerHorizontal").visible = false
	plus_banner.get_node("PlusSign").visible = false
	show_menu.emit(false, get_name())


#Upgrade sequence

func _on_plus_sign_clicked():
	if check_upgrade_req():
		thisData.status = "upgrading"
		print("upgrading to: " + str(thisData.level+1))
		get_progress_bar(thisData.level+1)

func get_progress_bar(UpgradeToLevel):
	if UpgradeToLevel >0:
		#start progress bar with a timer depending on level
		progress_bar.start(thisData.upgradeTimes[UpgradeToLevel-1])

	
func _on_progress_bar_finished_bar():
	#remove progress bar
	progress_bar.visible = false
	
	
	#create a completed popup
	complete_banner.get_node("BannerHorizontal").visible = true
	complete_banner.get_node("CompleteSign").visible = true
	complete_banner.process_mode = Node.PROCESS_MODE_INHERIT
	
	#when popup is clicked
	#_on_complete_banner_complete_sign_clicked()



func _on_complete_banner_complete_sign_clicked():

	#remove completed banner
	complete_banner.get_node("BannerHorizontal").visible = false
	complete_banner.get_node("CompleteSign").visible = false
	complete_banner.process_mode = Node.PROCESS_MODE_DISABLED
	
	#increase level
	thisData.level +=1
	
	#set status to idle to allow to be upgraded again
	thisData.status = "idle"
	
	#congratulations banner
	
	pop_up.openPopUp(get_name(), get_name()+"stat")
	
	#change texture of house
	
	get_node("KnightHouseSprite").texture = thisData.sprites[thisData.level-1]

	


func _on_ready():
	thisData = globalDataStore[get_name()]
	
	print(thisData)
