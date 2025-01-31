extends CharacterBody3D

@onready var player_walk = $"Player-Walk"
@onready var player_condition_block = $"Player-Condition-Block"
@onready var player_condition_power_up = $"Player-Condition-Power-Up"
@onready var player_condition_hurt = $"Player-Condition-Hurt"
@onready var player_action_dodge = $"Player-Action-Dodge"
@onready var player_action_attack = $"Player-Action-Attack"
@onready var player_condition_dead = $"Player-Condition-Dead"
@onready var blockSound = $BlockSound
@onready var powerUpSound = $PowerUpSound
@onready var hurtSound = $HurtSound
@onready var attackSound = $AttackSound
@onready var dodgeSound = $DodgeSound

const SPEED = 5
const MODULO_OP:float = 2
var num_of_books = 0;

var has_been_attacked = false;
var player_has_died = false;

@export var player_pos = get_position_delta()

func _physics_process(delta: float) -> void:
	if !Global.is_player_dead:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
	
		##Determine which dialogue to give player in Tutorial
		if Input.is_action_just_pressed("ui_interact"):
			if Global.talking_npc_in_range != Global.NPC.NONE:
				# dialog options
				if !Global.has_met_librarian && Global.talking_npc_in_range == Global.NPC.LIBRARIAN:
					DialogueManager.show_example_dialogue_balloon(load("res://tutorial.dialogue"))
				elif !Global.has_met_dewy && Global.has_met_librarian && Global.talking_npc_in_range == Global.NPC.DEWY && Global.is_holding_book:
					DialogueManager.show_example_dialogue_balloon(load("res://first_floor.dialogue"))
				elif Global.books_shelved == 10 && Global.has_met_dewy && Global.talking_npc_in_range == Global.NPC.LIBRARIAN:
					DialogueManager.show_example_dialogue_balloon(load("res://tutorial_second_talk.dialogue"))
				elif Global.current_floor_num == 12 && Global.talking_npc_in_range == Global.NPC.LIBRARIAN:
					DialogueManager.show_example_dialogue_balloon(load("res://final_confrontation_kinda.dialogue"))
			if Global.interactable_object_in_range != Global.INTERACTABLE.NONE:
				if Global.interactable_object_in_range == Global.INTERACTABLE.SHELF && Global.is_holding_book:
					Global.books_shelved += 1
					Global.books_left_to_shelve -= 1
					Global.is_holding_book = false
				elif Global.interactable_object_in_range == Global.INTERACTABLE.CART && Global.books_left_to_shelve != 0 && Global.is_holding_book != true:
					Global.is_holding_book = true
				elif Global.interactable_object_in_range == Global.INTERACTABLE.ELEVATOR && Global.floor_done:
					Global.next_floor += 1
					

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var is_sprinting := Input.is_key_pressed(KEY_SHIFT)
		
		Global.is_player_attacking = Input.is_key_pressed(KEY_Q)
		var noSoundsArePlaying = !blockSound.playing && !powerUpSound.playing && !hurtSound.playing && !attackSound.playing
		
		if Global.is_player_attacking:
			player_walk.hide()
			playAttackAnimAndSound(noSoundsArePlaying)
		else:
			if noSoundsArePlaying:
				player_action_attack.hide()
				player_walk.show()
		
		var is_blocking := Input.is_key_pressed(KEY_TAB)
		
		if is_blocking:
			player_walk.hide()
			playBlockAnimAndSound(noSoundsArePlaying)
		else:
			if noSoundsArePlaying:
				player_condition_block.hide()
				player_walk.show()
		
		var is_powering_up := Input.is_key_pressed(KEY_R)
		
		if is_powering_up:
			player_walk.hide()
			playPowerUpAndSound(noSoundsArePlaying)
		else:
			if noSoundsArePlaying:
				player_condition_power_up.hide()
				player_walk.show()
		
		var is_dodging := Input.is_key_pressed(KEY_2) && (Input.is_key_pressed(KEY_A) || Input.is_key_pressed(KEY_D))
		
		if is_dodging:
			player_walk.hide()
			playdodgeAnimAndSound(noSoundsArePlaying)
		else:
			if noSoundsArePlaying:
				player_action_dodge.hide()
				player_walk.show()

		if Global.is_hurting:
			player_walk.hide()
			playHurtAnimAndSound(noSoundsArePlaying)
		else:
			if noSoundsArePlaying:
				player_condition_hurt.hide()
				player_walk.show()
		
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction && !is_dodging:
			velocity.x = direction.x * _mult_speed(is_sprinting)
			velocity.z = direction.z * _mult_speed(is_sprinting)
			if (velocity.x > 0 and velocity.z == 0) or (velocity.x > 0 and velocity.z > 0):
				player_walk.play("walk_right")  
				Global.player_facing_left = false
			elif (velocity.x < 0 and velocity.z == 0) or (velocity.x < 0 and velocity.z > 0):
				player_walk.play("walk_left")  
				Global.player_facing_left = true
			elif velocity.x > 0 and velocity.z < 0:
				player_walk.play("walk_right_away") 
				Global.player_facing_left = false
			elif velocity.x < 0 and velocity.z < 0:
				player_walk.play("walk_left_away") 
				Global.player_facing_left = true
			elif velocity.z > 0 and velocity.x == 0:
				player_walk.play("walk_left")
				Global.player_facing_left = false
			elif velocity.z < 0 and velocity.x == 0:
				player_walk.play("walk_left_away")
				Global.player_facing_left = true
		elif direction && is_dodging:
			player_walk.hide()
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			player_walk.stop()

		move_and_slide()
		
		#Follow the player
		$Camera_Controller.position = lerp($Camera_Controller.position, position, .3)
		
		if !has_been_attacked && Global.is_enemy_attacking && !is_blocking:
			print("should lose health")
			has_been_attacked = true
			Global.is_hurting = true
			Global.player_health -= 1
			
		if !Global.is_enemy_attacking:
			Global.is_hurting = false
			has_been_attacked = false
			
		if Global.player_health <= 0:
			Global.is_player_dead = true
	else: 
		hideAllPlayerActions()
		player_walk.hide()
		if !player_has_died:
			player_condition_dead.show()
			player_condition_dead.play()
			player_has_died = true
	
func _mult_speed(playerIsSprinting):
	if playerIsSprinting:
		return SPEED * 2
	else:
		return SPEED
		
func playBlockAnimAndSound(areSoundsPlaying:bool) -> void:
	if areSoundsPlaying:
		hideAllPlayerActions()
		player_condition_block.show()
		player_condition_block.play("player_block")
		blockSound.play()
		
	
func playHurtAnimAndSound(areSoundsPlaying:bool) -> void:
	if areSoundsPlaying:
		hideAllPlayerActions()
		player_condition_hurt.show()
		player_condition_hurt.play("player_hurt")
		hurtSound.play()
		Global.player_health -= 1
	
func playPowerUpAndSound(areSoundsPlaying:bool) -> void:
	if areSoundsPlaying:
		hideAllPlayerActions()
		player_condition_power_up.show()
		player_condition_power_up.play("power_up")
		powerUpSound.play()
		
func playAttackAnimAndSound(areSoundsPlaying:bool) -> void:
	if areSoundsPlaying:
		hideAllPlayerActions()
		player_action_attack.show()
		player_action_attack.play("player_attack")
		attackSound.play()
		
func playdodgeAnimAndSound(areSoundsPlaying:bool) -> void:
	if areSoundsPlaying:
		hideAllPlayerActions()
		player_action_dodge.show()
		if Input.is_key_pressed(KEY_A):
			player_action_dodge.play("player_dodge_left")
		else:
			player_action_dodge.play("player_dodge_right")
		dodgeSound.play()

func hideAllPlayerActions() -> void:
	player_condition_power_up.hide()
	player_condition_block.hide()
	player_condition_hurt.hide()
	player_action_dodge.hide()
	player_action_attack.hide()

func _on_trigger_zone_body_entered(body: Node3D) -> void:
	if body.has_method("isInteractable"):
		if body.has_method("isNPC"):
			if body.has_method("isLibrarian"):
				Global.talking_npc_in_range = Global.NPC.LIBRARIAN
			elif body.has_method("isDewy"): 
				Global.talking_npc_in_range = Global.NPC.DEWY
		elif body.has_method("isEnemy"):
			Global.enemy_in_range = Global.ENEMY.SKELETON


func _on_trigger_zone_body_exited(body: Node3D) -> void:
	if body.has_method("isInteractable"):
		if body.has_method("isNPC"):
			if body.has_method("isLibrarian"):
				Global.talking_npc_in_range = Global.NPC.NONE
			elif body.has_method("isDewy"): 
				Global.talking_npc_in_range = Global.NPC.NONE
		elif body.has_method("isEnemy"):
			Global.enemy_in_range = Global.ENEMY.NONE
	
func is_player():
	pass
