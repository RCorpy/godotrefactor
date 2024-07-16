extends Area2D

@onready var player = $".."
@onready var pop_up_text = $PopUpText

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func closePopUp():
	visible = false
	player.movementDisabled = false
	
func openPopUp(text1,text2):
	#text
	pop_up_text.text = "[center]"+ tr(text1) +"\n" + tr(text2)
	#visibility and movement
	visible = true
	player.movementDisabled = true


func _on_pop_up_button_pressed():
	closePopUp()
