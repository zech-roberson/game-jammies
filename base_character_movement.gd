extends CharacterBody3D

@onready var player_walk = $"Player-Walk"
@onready var player_condition_block = $"Player-Condition-Block"
@onready var player_condition_power_up = $"Player-Condition-Power-Up"
@onready var blockSound = $BlockSound
@onready var powerUpSound = $PowerUpSound

const SPEED = 5
const MODULO_OP:float = 2
var num_of_books = 0;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var is_sprinting := Input.is_key_pressed(KEY_SHIFT)
	
	var noSoundsArePlaying = !blockSound.playing && !powerUpSound.playing
	
	var is_blocking := Input.is_key_pressed(KEY_B)
	
	if is_blocking:
		player_walk.hide()
		playBlockAnimAndSound(noSoundsArePlaying)
	else:
		if noSoundsArePlaying:
			player_condition_block.hide()
			player_walk.show()
	
	var is_powering_up := Input.is_key_pressed(KEY_J)
	
	if is_powering_up:
		player_walk.hide()
		playPowerUpAndSound(noSoundsArePlaying)
	else:
		if noSoundsArePlaying:
			player_condition_power_up.hide()
			player_walk.show()
	
	var is_hurting := Input.is_key_pressed(KEY_H)

	#if is_hurting:
		#player_condition_block.play("player_hurt")
		#player_condition_block.hide()
		
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * _mult_speed(is_sprinting)
		velocity.z = direction.z * _mult_speed(is_sprinting)
		if (velocity.x > 0 and velocity.z == 0) or (velocity.x > 0 and velocity.z > 0):
			player_walk.play("walk_right")  
		elif (velocity.x < 0 and velocity.z == 0) or (velocity.x < 0 and velocity.z > 0):
			player_walk.play("walk_left")  
		elif velocity.x > 0 and velocity.z < 0:
			player_walk.play("walk_right_away") 
		elif velocity.x < 0 and velocity.z < 0:
			player_walk.play("walk_left_away") 
		elif velocity.z > 0 and velocity.x == 0:
			player_walk.play("walk_left")
		elif velocity.z < 0 and velocity.x == 0:
			player_walk.play("walk_left_away")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		player_walk.stop()

	move_and_slide()
	
	#Follow the player
	$Camera_Controller.position = lerp($Camera_Controller.position, position, .3)
	
func _mult_speed(playerIsSprinting):
	if playerIsSprinting:
		return SPEED * 2
	else:
		return SPEED
		
func playBlockAnimAndSound(areSoundsPlaying:bool) -> void:
	if areSoundsPlaying:
		player_condition_power_up.hide()
		player_condition_block.show()
		player_condition_block.play("player_block")
		blockSound.play()
		
	
func playHurtAnimAndSound(areSoundsPLaying:bool) -> void:
	pass
	
func playPowerUpAndSound(areSoundsPlaying:bool) -> void:
	if areSoundsPlaying:
		player_condition_block.hide()
		player_condition_power_up.show()
		player_condition_power_up.play("power_up")
		powerUpSound.play()
