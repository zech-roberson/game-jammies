extends Node3D

@onready var interactScreen = $InteractionLayer/InteractionScreen
@onready var interactSrceenWithBookshelf = $InteractionLayer/InteractionScreenWithBookshelf
@onready var elevator = $Elevator_Sprite/AnimatedSprite3D

# put scene's you want added to your floor here
# shelf is 4x2.5x.5
var shelf_scene = preload("res://blender_assets/bookshelf_better.blend")
var table_scene = preload("res://blender_assets/table.blend")
var basic_floor = preload("res://blender_assets/hospital_floor.blend")
var rug_floor = preload("res://blender_assets/rug_floor.blend")

# hardcoding the size of the floors to 50x50 meters,
#	25 meters left of the origin, 25 right of the origin
var rowNum = -25
var colNum = -25

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		togglePause()
		
func togglePause():
	var tree = get_tree()
	tree.paused = !tree.paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.floor_number = Global.FLOORS.FIRST
	
	print("Loading flooring.\n")
	# make a text file of 50 columns and 50 rows representing the
	#	floor layout. See floor.txt for example
	var layoutFile = FileAccess.open("res://floors/6/floor.txt", FileAccess.READ)
	var row = null
	var floor = null
	var item = null
	var item_placement_y = 0
	while layoutFile.get_position() < layoutFile.get_length():
		row = layoutFile.get_line()
		for tile in row:
			# like a switch statement in C++
			match tile:
				".":
					floor = basic_floor.instantiate()
				"r":
					floor = rug_floor.instantiate()
				# add whatever else you want automatically added to the floor
				#	here
			if (floor):
				add_child(floor)
				# the top of flooring should always be at y level zero
				#	so lower our 1m cube half a meter
				floor.set_global_position(Vector3(colNum,-0.5,rowNum))
				floor = null
			colNum += 1
		colNum = -25
		rowNum += 1
	rowNum = -25
	print("Loading floor items.\n")
	layoutFile = FileAccess.open("res://floors/6/layout.txt", FileAccess.READ)
	while layoutFile.get_position() < layoutFile.get_length():
		row = layoutFile.get_line()
		for tile in row:
			match tile:
				"h":
					item = shelf_scene.instantiate()
					# set this so that your item "sits" on the ground,
					#	which is at y == 0. Or figure out how to snap
					#	to the ground using this code.
					item_placement_y = 3
				"t":
					item = table_scene.instantiate()
					item_placement_y = 0.5
			if (item):
				add_child(item)
				# prolly should just divide height of item and assign
				#	result to Vector3.y...
				item.set_global_position(Vector3(colNum,item_placement_y,rowNum))
				item = null
			colNum += 1
		colNum = -25
		rowNum += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.interactable_object_in_range == Global.INTERACTABLE.CART && Global.has_met_librarian:
		interactScreen.show()
		if Input.is_action_just_pressed("ui_interact"):
			Global.books_left_to_shelve_floor_1 -= 1
			Global.is_holding_book = true
	elif Global.interactable_object_in_range == Global.INTERACTABLE.ELEVATOR && Global.books_shelved == 10:
		interactScreen.show()
	elif Global.interactable_object_in_range == Global.INTERACTABLE.SHELF && Global.is_holding_book:
		interactSrceenWithBookshelf.show()
		if Input.is_action_just_pressed("ui_interact") || Input.is_action_just_pressed("power_up"):
			Global.is_holding_book = false
			Global.books_shelved += 1
	else:
		interactScreen.hide()
		interactSrceenWithBookshelf.hide()
