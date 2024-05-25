extends StaticBody2D

signal show_menu

@onready var knight_house_data_store = %KnightHouseDataStore
@onready var plus_banner = %PlusBanner
@onready var complete_banner = %CompleteBanner
@onready var progress_bar= %ProgressBar
@onready var globalDataStore = $"../DataStore"


func check_upgrade_req():
	return true


func _on_knight_house_interact_area_create_pop_up():
	
	show_menu.emit(true, get_name())
	## if there is nothing going on (idle) -> show me the upgrade button
	
	if knight_house_data_store.status == "idle" && knight_house_data_store.level < knight_house_data_store.maxLevel:
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
		knight_house_data_store.status = "upgrading"
		print("upgrading to: " + str(knight_house_data_store.level+1))
		get_progress_bar(knight_house_data_store.level+1)

func get_progress_bar(UpgradeToLevel):
	if UpgradeToLevel >0:
		#start progress bar with a timer depending on level
		progress_bar.start(knight_house_data_store.upgradeTimes[UpgradeToLevel-1])

	
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
	knight_house_data_store.level +=1
	
	#set status to idle to allow to be upgraded again
	knight_house_data_store.status = "idle"
	
	
	#change texture of house
	
	get_node("KnightHouseSprite").texture = knight_house_data_store.sprites[knight_house_data_store.level-1]

	


func _on_knight_house_data_store_get_house_data(node_name):
	
	knight_house_data_store.level = globalDataStore[node_name].level
	knight_house_data_store.maxLevel = globalDataStore[node_name].maxLevel
	knight_house_data_store.upgradeTimes = globalDataStore[node_name].upgradeTimes
	knight_house_data_store.status = globalDataStore[node_name].status
	knight_house_data_store.progressValue = globalDataStore[node_name].progressValue
	knight_house_data_store.sprites = globalDataStore[node_name].sprites
	
