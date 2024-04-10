extends Area2D


func _on_input_event(viewport, event, shape_idx):
	if (event.button_mask):
		print("LETS DO SOME SHIT")
		get_node("BannerHorizontal").visible = false
		get_node("PlusSign").visible = false
		get_node("PlusBannerArea").disabled = true
		
