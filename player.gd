extends CharacterBody2D


@onready var playerAnimatedSprite = %playerAnimatedSprite
var targetVector
var movementDisabled = false
const SPEED = 400

func _input(event):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func use_this_camera():
	$PlayerCamera.make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length()<0.01:
		playerAnimatedSprite.animation = "idle"
	else:
		playerAnimatedSprite.animation = "walk"
	
	var direction = Input.is_action_pressed("click")
	if movementDisabled:
		direction = false
	if direction:
		targetVector = get_local_mouse_position()
		
		if targetVector.length()>10:
			velocity = targetVector.normalized() * SPEED
			playerAnimatedSprite.flip_h = targetVector.x < 0
		else:
			velocity = Vector2(0,0)
	else:
		velocity = Vector2(0,0)
	move_and_slide()

