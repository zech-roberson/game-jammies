@tool
extends StaticBody3D
class_name floorGen

# flooring
var rug_floor = preload("res://blender_assets/rug_floor.blend")
var stone_floor = preload("res://blender_assets/stone_floor.blend")
var wood_floor = preload("res://blender_assets/wood_floor.blend")
var cobble_floor = preload("res://blender_assets/cobble_floor.blend")
var red_carpet_floor = preload("res://blender_assets/red_carpet.blend")
var dirt_floor = preload("res://blender_assets/dirt_floor.blend")
var grass_floor = preload("res://blender_assets/grass_floor.blend")
var dark_floor = preload("res://blender_assets/dark_floor.blend")
var hospital_floor = preload("res://blender_assets/hospital_floor.blend")

# ceiling
var shiny_ceiling = preload("res://blender_assets/shiny_ceiling.blend")

# furniture
var shelf_scene = preload("res://assets/models/bookshelf_3m.tscn")
var table_scene = preload("res://blender_assets/table.blend")
var computer_scene = preload("res://blender_assets/computer.blend")
var cart = preload("res://book_cart.tscn")
var elevator = preload("res://elevator_sprite.tscn")
var wall = preload("res://blender_assets/wall_bookshelf_back.blend")

# playable and non-playable characters
var player = preload("res://base_character.tscn")
var dewey = preload("res://dewy_decimal.tscn")
var librarian = preload("res://librarian_character.tscn")

var ceiling_walls_floor = preload("res://floors/wall_ceiling_lights.tscn")

# hardcoding the size of the floors to 50x50 meters,
#	25 meters left of the origin, 25 right of the origin
var rowNum = -25
var colNum = -25

const floor_rot = [0, 90, 180, 270]
var rando = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _init(flr_num, shlv_goal):
	Global.floor_number = flr_num
	
	Global.books_shelved = 0
	Global.books_left_to_shelve = shlv_goal
	Global.floor_done = false
	
	add_child(ceiling_walls_floor.instantiate())

func load_flooring(flooring_file):
	var row = null
	var floor = null
	var item = null
	var infile = FileAccess.open(flooring_file, FileAccess.READ)
	if infile:
		print("Loading flooring.\n")
		while infile.get_position() < infile.get_length():
			row = infile.get_line()
			for tile in row:
				# like a switch statement in C++
				match tile:
					".":
						floor = wood_floor.instantiate()
					"r":
						floor = rug_floor.instantiate()
					"s":
						floor = stone_floor.instantiate()
					"c":
						floor = cobble_floor.instantiate()
					"g":
						floor = grass_floor.instantiate()
					"t":
						floor = red_carpet_floor.instantiate()
					"d":
						floor = dark_floor.instantiate()
					"i":
						floor = dirt_floor.instantiate()
					"h":
						floor = hospital_floor.instantiate()
					# add whatever else you want automatically added to the floor
					#	here
				if (floor):
					add_child(floor)
					# the top of flooring should always be at y level zero
					#	so lower our 1m cube half a meter
					floor.set_global_position(Vector3(colNum,-0.5,rowNum))
					# randomly orient the floor to get some variety
					floor.set_rotation_degrees(Vector3(0,floor_rot[rando.randi_range(0,3)],0))
					floor = null
				colNum += 1
			colNum = -25
			rowNum += 1
		rowNum = -25
		
func load_furniture(furniture_file):
	var row = null
	var floor = null
	var item = null
	var item_placement_y = 0
	var item_placement_rot = 0
	var item_size = Vector3(1,1,1)
	var infile = FileAccess.open(furniture_file, FileAccess.READ)
	print("Loading floor items.\n")
	while infile.get_position() < infile.get_length():
		row = infile.get_line()
		for tile in row:
			# hardcoded size of the 3m-long bookshelves
			item_size = Vector3(3, 2.5, 0.5)
			item_placement_rot = 0
			match tile:
				"p":
					item = player.instantiate()
					item_placement_y = 1
				"h":
					item = shelf_scene.instantiate()
					# set this so that your item "sits" on the ground,
					#	which is at y == 0. Or figure out how to snap
					#	to the ground using this code.
					item_placement_y = 1.25
				"v":
					item = shelf_scene.instantiate()
					item_placement_y = 1.25
					item_placement_rot = 90
				"t":
					item = table_scene.instantiate()
					item_placement_y = 0.5
					item_size = Vector3(1,1,1)
				"c":
					item = computer_scene.instantiate()
					item_placement_y = 0.5
					item_size = Vector3(2,1,2)
				"3":
					item = wall.instantiate()
					item_placement_y = 2.5
					item_placement_rot = 90
					item_size = Vector3(5, 5, 0.25)
				"w":
					item = wall.instantiate()
					item_placement_y = 2.5
					item_size = Vector3(5, 5, 0.25)
				"b":
					item = cart.instantiate()
					item_placement_y = 0.198
				"d":
					item = dewey.instantiate()
					item_placement_y = .8
				"l":
					item = librarian.instantiate()
					item_placement_y = .75
				"e":
					item = elevator.instantiate()
					item_placement_y = 1
			if (item):
				add_child(item)
				# prolly should just divide height of item and assign
				#	result to Vector3.y...
				item.set_global_position(Vector3(colNum,item_placement_y,rowNum))
				item.set_rotation_degrees(Vector3(0,item_placement_rot,0))
				# create collision object the same dimensions as item
				var shape3d = CollisionShape3D.new()
				var box = BoxShape3D.new()
				box.size = item_size
				shape3d.set_shape(box)
				shape3d.set_global_position(item.get_global_position())
				shape3d.set_rotation_degrees(item.get_rotation_degrees())
				add_child(shape3d)
				
				item = null
			colNum += 1
		colNum = -25
		rowNum += 1
	rowNum = -25

func load_ceiling():
	var item = null
	var item_placement_y = 0
	var item_placement_rot = 0
	var item_size = Vector3(1,1,1)
	print("Loading ceiling tiles.")
	item_placement_y = 5
	item_placement_rot = 180
	for x in range(rowNum, -rowNum):
		for y in range(colNum, -colNum):
			item = shiny_ceiling.instantiate()
			if (item):
				add_child(item)
				item.set_global_position(Vector3(colNum,item_placement_y,rowNum))
				item.set_rotation_degrees(Vector3(item_placement_rot,0,0))
				item = null
			colNum += 1
		colNum = -25
		rowNum += 1
	rowNum = -25

func _process(delta: float) -> void:
	pass
