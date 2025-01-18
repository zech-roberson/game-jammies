extends CharacterBody3D

@onready var player = $AnimatedSprite3D

const SPEED = 5

var num_of_books = 0;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var is_sprinting := Input.is_key_pressed(KEY_SHIFT)
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * _mult_speed(is_sprinting)
		velocity.z = direction.z * _mult_speed(is_sprinting)
		if (velocity.x > 0 and velocity.z == 0) or (velocity.x > 0 and velocity.z > 0):
			player.play("walk_right")  
		elif (velocity.x < 0 and velocity.z == 0) or (velocity.x < 0 and velocity.z > 0):
			player.play("walk_left")  
		elif velocity.x > 0 and velocity.z < 0:
			player.play("walk_right_away") 
		elif velocity.x < 0 and velocity.z < 0:
			player.play("walk_left_away") 
		elif velocity.z > 0 and velocity.x == 0:
			player.play("walk_left")
		elif velocity.z < 0 and velocity.x == 0:
			player.play("walk_left_away")
		else:
			player.stop()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	#Follow the player
	$Camera_Controller.position = lerp($Camera_Controller.position, position, .3)
	
func _mult_speed(playerIsSprinting):
	if playerIsSprinting:
		return SPEED * 2
	else:
		return SPEED
