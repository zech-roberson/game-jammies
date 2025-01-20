extends Node3D

var shelf_scene = preload("res://blender_assets/bookshelf_better.blend")
var rowNum = -50
var colNum = -50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Loading floor layout.\n")
	var layoutFile = FileAccess.open("res://floors/6/layout.txt", FileAccess.READ)
	var row = null
	while layoutFile.get_position() < layoutFile.get_length():
		row = layoutFile.get_line()
		for tile in row:
			match tile:
				"h":
					var shelf = shelf_scene.instantiate()
					add_child(shelf)
					shelf.set_global_position(Vector3(colNum,0,rowNum))
			colNum += 1
		colNum = -50
		rowNum += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = find_child("Camera3D")
	var rot = camera.get_rotation_degrees()
	camera.set_rotation_degrees(Vector3(0,rot.y+0.1,0))
