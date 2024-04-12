extends StaticBody2D

signal show_menu

@onready var knight_house_data_store = %KnightHouseDataStore
@onready var plus_banner = %PlusBanner

func getHouseSprite():
	return get_node("KnightHouseSprite")
	
func check_upgrade_req():
	return true

func _on_knight_house_interact_area_create_pop_up():
	
	## if there is nothing going on (idle) -> show me the upgrade button
	if knight_house_data_store.status == "idle":
		plus_banner.process_mode = Node.PROCESS_MODE_INHERIT
		plus_banner.get_node("BannerHorizontal").visible = true
		plus_banner.get_node("PlusSign").visible = true
		show_menu.emit(true)
	

func _on_knight_house_interact_area_remove_pop_up():
	plus_banner.process_mode = Node.PROCESS_MODE_DISABLED
	plus_banner.get_node("BannerHorizontal").visible = false
	plus_banner.get_node("PlusSign").visible = false
	show_menu.emit(false)






#Upgrade sequence

func _on_plus_sign_clicked():
	if check_upgrade_req():
		get_progress_bar(knight_house_data_store.level+1)

func get_progress_bar(UpgradeToLevel):
	knight_house_data_store.status = "upgrading"
	print("upgrading to: " + str(UpgradeToLevel))
	get_node("KnightHouseSprite").texture = knight_house_data_store.LOWLEVELHOUSE

func on_progress_bar_completed():
	pass
	
func on_completed_click():
	pass
