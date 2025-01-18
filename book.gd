extends Area3D

const ROT_DEG = 2 # number of degrees the book rotates eveyr frame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_DEG))
	
	

func _on_body_entered(body: Node3D) -> void:
	Global.Books += 1
	print(Global.Books)
	if Global.Books >= Global.NUM_BOOKS_TO_WIN:
		get_tree().change_scene_to_file("res://node_2d.tscn")
	queue_free()
