extends Area2D

signal plus_sign_clicked

func _on_input_event(viewport, event, shape_idx):
	print(event)
	if (event.button_mask && event.get("pressed")):
		if get_node("BannerHorizontal").visible == true:
			get_node("BannerHorizontal").visible = false
			get_node("PlusSign").visible = false
			process_mode = Node.PROCESS_MODE_DISABLED
			plus_sign_clicked.emit()
		
