extends ProgressBar

signal finishedBar
var run = false
var upgradeTime = 1

func start(time):
	visible = true
	value = 0
	run = true
	upgradeTime = time
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run:
		value += delta * 1000 / upgradeTime
		if value >= 100:
			#get completed pop up and wait for its click
			print("finished")
			run = false
			finishedBar.emit()
			
	else:
		pass
