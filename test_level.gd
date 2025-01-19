extends Node3D

func togglePause():
	var tree = get_tree()
	tree.paused = !tree.paused
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		togglePause()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Books = 0
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
