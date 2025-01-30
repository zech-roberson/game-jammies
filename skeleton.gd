extends CharacterBody3D

@onready var skeleton = $skeleton_character

const SPEED = 2.5

@export var direction := Vector3(1,0,0);

var is_attacking := false
var has_enterered_range := false
var has_been_attacked := false
var health = 5

func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
	
	velocity.x = SPEED * direction.x
	velocity.z = SPEED * direction.z
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if direction.x < 0 && !is_attacking:
		skeleton.play("walk_left")
		#$Walk_sound.play()
	elif direction.x > 0 && !is_attacking:
		skeleton.play("walk_right")
		#$Walk_sound.play()
	#elif direction.x == 0 || is_attacking:
		#$Walk_sound.stop() 
	
	if has_enterered_range && Global.is_player_attacking && !has_been_attacked:
		health -= 1	
		has_been_attacked = true
	
	if is_on_wall() && !has_enterered_range:
		direction.x *= -1
		direction.z *= -1


func _on_area_3d_body_entered(body: Node3D) -> void:
	has_enterered_range = true
	skeleton.pause()
	if body.has_method("is_player") && !is_attacking:
		print("attack player")
		is_attacking = true
		Global.is_enemy_attacking = true
		if !Global.player_facing_left:
			skeleton.play("attack_left")
		else:
			skeleton.play("attack_right")


func _on_area_3d_body_exited(body: Node3D) -> void:
	has_enterered_range = false
	has_been_attacked = false
	if body.has_method("is_player"):
		is_attacking = false
		Global.is_enemy_attacking = false
