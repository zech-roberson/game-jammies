extends Node3D

func togglePause():
	var tree = get_tree()
	tree.paused = !tree.paused
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		togglePause()
		
@onready var brain = $"Brain Sprite 3D"
@onready var star = $"Starbusrt_Particle 3d"
@onready var hud = $HUD
@onready var dewy_demo = $StaticBody3D3/AudioStreamPlayer2D
@onready var librarian = $"Librarian Character/AnimatedSprite3D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Books = 0
	librarian.play("good_walking_left")
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_trigger_zone_body_exited(body: Node3D) -> void:
	if brain.visible:
		brain.hide()
	else:
		brain.show()
		
	if star.visible:
		star.hide()
	else:
		star.show()
		
	if hud.visible:
		hud.hide()
	else:
		hud.show()
	

func _on_trigger_zone_2_body_exited(body: Node3D) -> void:
	if brain.visible:
		brain.hide()
	else:
		brain.show()
		
	if star.visible:
		star.hide()
	else:
		star.show()
		
	if hud.visible:
		hud.hide()
	else:
		hud.show()


func _on_trigger_zone_3_body_exited(body: Node3D) -> void:
		dewy_demo.play()
