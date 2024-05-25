extends StaticBody2D

signal show_menu

@onready var knight_house_data_store = %KnightHouseDataStore
@onready var plus_banner = %PlusBanner
@onready var complete_banner = %CompleteBanner
@onready var progress_bar= %ProgressBar

func getHouseSprite():
	return get_node("KnightHouseSprite")
	
func check_upgrade_req():
	return true

func _on_knight_house_interact_area_create_pop_up():
	show_menu.emit(true)
	## if there is nothing going on (idle) -> show me the upgrade button
	if knight_house_data_store.status == "idle" && knight_house_data_store.level < knight_house_data_store.maxLevel:
		plus_banner.process_mode = Node.PROCESS_MODE_INHERIT
		plus_banner.get_node("BannerHorizontal").visible = true
		plus_banner.get_node("PlusSign").visible = true
		
	

func _on_knight_house_interact_area_remove_pop_up():
	plus_banner.process_mode = Node.PROCESS_MODE_DISABLED
	plus_banner.get_node("BannerHorizontal").visible = false
	plus_banner.get_node("PlusSign").visible = false
	show_menu.emit(false)


#Upgrade sequence

func _on_plus_sign_clicked():
	if check_upgrade_req():
		knight_house_data_store.status = "upgrading"
		print("upgrading to: " + str(knight_house_data_store.level+1))
		get_progress_bar(knight_house_data_store.level+1)

func get_progress_bar(UpgradeToLevel):
	if UpgradeToLevel >0:
		#start progress bar with a timer dependin on level
		progress_bar.start(knight_house_data_store.upgradeTimes[knight_house_data_store.level])

	
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
	if knight_house_data_store.level>0 && knight_house_data_store.level <3:
		get_node("KnightHouseSprite").texture = knight_house_data_store.LOWLEVELHOUSE
	if knight_house_data_store.level>2 && knight_house_data_store.level <5:
		get_node("KnightHouseSprite").texture = knight_house_data_store.HIGHLEVELHOUSE
	
