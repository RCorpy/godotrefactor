extends Area2D

@onready var player = $".."
@onready var pop_up_text = $PopUpText

var currentTextContinue = null
var currentTextArray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	if $"../Fight".round ==1:
		openPopUp("start","","start2")

func closePopUp():
	visible = false
	player.movementDisabled = false
	
func openPopUp(text1,text2: String = "",textContinue: String = ""):
	#text
	pop_up_text.text = "[center]"+ tr(text1) +"\n" + tr(text2)
	#visibility and movement
	visible = true
	player.movementDisabled = true
	currentTextContinue = ""
	currentTextContinue = textContinue


func _on_pop_up_button_pressed():
	closePopUp()

	if currentTextContinue:
		currentTextArray = tr(currentTextContinue).split(" ")
		
		if len(currentTextArray)==3:
			openPopUp(currentTextArray[0], currentTextArray[1], currentTextArray[2])
		elif len(currentTextArray)==2:
			openPopUp(currentTextArray[0], currentTextArray[1])
		else:
			openPopUp(currentTextArray[0])
		#
