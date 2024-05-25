extends Area2D

signal complete_sign_clicked
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_input_event(viewport, event, shape_idx):
	if (event.button_mask && event.get("pressed")):
		if get_node("BannerHorizontal").visible == true:
			get_node("BannerHorizontal").visible = false
			get_node("CompleteSign").visible = false
			process_mode = Node.PROCESS_MODE_DISABLED
			complete_sign_clicked.emit()
