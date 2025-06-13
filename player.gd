extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -1000.0
var spawn_position = Vector2(0,0)
var num = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY * -1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and is_on_floor():
		velocity.x = direction * SPEED
	elif direction:
		velocity.x = direction * (SPEED*0.25)
	else:
		velocity.x = move_toward(velocity.x, velocity.y, SPEED) 

	move_and_slide()

	# Respawn
	if position.y > 50 or position.y < -1850:
		position = spawn_position
