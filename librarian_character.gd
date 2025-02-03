extends CharacterBody3D

@onready var librarian = $librarian

const SPEED = 1.0
	
@export var direction := Vector3(-1,0,0);
@export var librarian_attack = false

var is_attacking := false

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * direction.x
	velocity.z = SPEED * direction.z
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if !Global.has_met_librarian || !Global.boss_battle_started:
		direction.x = 0
	else:
		direction.x = -1
	
	
	if direction.x < 0 && !is_attacking:
		if !Global.librarian_is_antagonist && !Global.librarian_is_sick:
			librarian.play("good_walking_left")
		else:
			librarian.play("sick_walking_left")
	elif direction.x > 0 && !is_attacking:
		if !Global.librarian_is_antagonist && !Global.librarian_is_sick:
			librarian.play("good_walking_right")
		else:
			librarian.play("sick_walking_right")
			
	if direction:
			if (velocity.x > 0 and velocity.z == 0) or (velocity.x > 0 and velocity.z > 0):
				if !Global.librarian_is_antagonist || !Global.librarian_is_sick:
					librarian.play("good_walking_right")
				else:
					librarian.play("sick_walking_right")
			elif (velocity.x < 0 and velocity.z == 0) or (velocity.x < 0 and velocity.z > 0):
				if !Global.librarian_is_antagonist || !Global.librarian_is_sick:
					librarian.play("good_walking_left")
				else:
					librarian.play("sick_walking_left") 
			elif velocity.x > 0 and velocity.z < 0:
				if !Global.librarian_is_antagonist || !Global.librarian_is_sick:
					librarian.play("good_walking_right_away")
				else:
					librarian.play("sick_walking_right_away")
			elif velocity.x < 0 and velocity.z < 0:
				if !Global.librarian_is_antagonist || !Global.librarian_is_sick:
					librarian.play("good_walking_left_away")
				else:
					librarian.play("sick_walking_left_away") 
			elif velocity.z > 0 and velocity.x == 0:
				if !Global.librarian_is_antagonist || !Global.librarian_is_sick:
					librarian.play("good_walking_left")
				else:
					librarian.play("sick_walking_left")
			elif velocity.z < 0 and velocity.x == 0:
				if !Global.librarian_is_antagonist || !Global.librarian_is_sick:
					librarian.play("good_walking_left_away")
				else:
					librarian.play("sick_walking_left_away")
			else:
				librarian.stop()
				
	if librarian_attack:
#		Global.is_enemy_attacking
		librarian.play("attack")
	else:
		librarian.stop()
	
	if is_on_wall():
		direction.x *= -1
		direction.z *= -1
	
func isInteractable():
	pass

func isNPC():
	pass
	
func isLibrarian():
	pass


func _on_trigger_zone_body_entered(body: Node3D) -> void:
	if body.has_method("isPlayer"):
		librarian_attack = true


func _on_trigger_zone_body_exited(body: Node3D) -> void:
	if body.has_method("isPlayer"):
		librarian_attack = false
