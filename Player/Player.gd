extends CharacterBody2D

const PLAYER_ACCELERATION = 25
const PLAYER_MAX_SPEED = 100
const PLAYER_FRICTION = 25

# vector2 is an x and y coord and ZERO is shorthand for 0,0
var playerVelocity = Vector2.ZERO

func _physics_process(delta):
	print(playerVelocity)
	
	var input_vector = Vector2.ZERO
	# the classic 1, -1 etc movement technique
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# to handle faster diaganol movement
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		playerVelocity += input_vector * PLAYER_ACCELERATION * delta
		playerVelocity = playerVelocity.limit_length(PLAYER_MAX_SPEED * delta)
	else:
		# decrease velocity by friction until reaching zero
		playerVelocity = playerVelocity.move_toward(Vector2.ZERO, PLAYER_FRICTION * delta)
		
	move_and_collide(playerVelocity)

