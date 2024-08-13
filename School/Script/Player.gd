extends CharacterBody2D

@onready var player_animation = $PlayerAnimation
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pressedFlag = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if pressedFlag == false:
		velocity.x = move_toward(velocity.x, 0, 1)
	move_and_slide()

func leftPressed():
	player_animation.play("left")
	velocity.x += 20
	move_and_slide()
func rightPressed():
	player_animation.play("right")
	velocity.x += 20
	move_and_slide()
	
func stopPlayer():
	velocity.x = 0
	move_and_slide()
