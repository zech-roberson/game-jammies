#@tool
#extends StaticBody3D

# flooring
static var rug_floor = preload("res://blender_assets/rug_floor.blend")
static var stone_floor = preload("res://blender_assets/stone_floor.blend")
static var wood_floor = preload("res://blender_assets/wood_floor.blend")
static var cobble_floor = preload("res://blender_assets/cobble_floor.blend")
static var red_carpet_floor = preload("res://blender_assets/red_carpet.blend")
static var dirt_floor = preload("res://blender_assets/dirt_floor.blend")
static var grass_floor = preload("res://blender_assets/grass_floor.blend")
static var dark_floor = preload("res://blender_assets/dark_floor.blend")
static var hospital_floor = preload("res://blender_assets/hospital_floor.blend")

# ceiling
static var shiny_ceiling = preload("res://blender_assets/shiny_ceiling.blend")

# furniture
static var shelf_scene = preload("res://assets/models/bookshelf_3m.tscn")
static var table_scene = preload("res://blender_assets/table.blend")
static var computer_scene = preload("res://blender_assets/computer.blend")
static var cart = preload("res://book_cart.tscn")
static var elevator = preload("res://elevator_sprite.tscn")
static var wall = preload("res://blender_assets/wall_bookshelf_back.blend")

# playable and non-playable characters
static var player = preload("res://base_character.tscn")
static var dewey = preload("res://dewy_decimal.tscn")
static var librarian = preload("res://librarian_character.tscn")

# hardcoding the size of the floors to 50x50 meters,
#	25 meters left of the origin, 25 right of the origin
static var rowNum = -25
static var colNum = -25

static var floor_rot = [0, 90, 180, 270]
static var rando = RandomNumberGenerator.new()

static func load_flooring(output_array, flooring_file) -> Array:
	var row = null
	var floor_obj = null
	var infile = FileAccess.open(flooring_file, FileAccess.READ)
	if infile:
		print("Loading flooring.\n")
		while infile.get_position() < infile.get_length():
			row = infile.get_line()
			for tile in row:
				# like a switch statement in C++
				match tile:
					".":
						floor_obj = wood_floor
					"r":
						floor_obj = rug_floor
					"s":
						floor_obj = stone_floor
					"c":
						floor_obj = cobble_floor
					"g":
						floor_obj = grass_floor
					"t":
						floor_obj = red_carpet_floor
					"d":
						floor_obj = dark_floor
					"i":
						floor_obj = dirt_floor
					"h":
						floor_obj = hospital_floor
					# add whatever else you want automatically added to the floor
					#	here
				if (floor_obj):
					output_array.append({
						"object": floor_obj,
						"size": null,
						"position": Vector3(colNum,-0.5,rowNum), 
						"rot": Vector3(0,floor_rot[rando.randi_range(0,3)],0)
					})
					floor_obj = null
				colNum += 1
			colNum = -25
			rowNum += 1
		rowNum = -25
	return output_array

static func load_furniture(output_array, furniture_file):
	var row = null
	var item = null
	var item_placement_y = 0
	var item_placement_rot = 0
	var item_size = Vector3(1,1,1)
	var infile = FileAccess.open(furniture_file, FileAccess.READ)
	if infile:
		print("Loading floor items.\n")
		while infile.get_position() < infile.get_length():
			row = infile.get_line()
			for tile in row:
				# hardcoded size of the 3m-long bookshelves
				item_size = Vector3(3, 2.5, 0.5)
				item_placement_rot = 0
				match tile:
					"p":
						item = player
						item_placement_y = 1
					"h":
						item = shelf_scene
						# set this so that your item "sits" on the ground,
						#	which is at y == 0. Or figure out how to snap
						#	to the ground using this code.
						item_placement_y = 1.25
					"v":
						item = shelf_scene
						item_placement_y = 1.25
						item_placement_rot = 90
					"t":
						item = table_scene
						item_placement_y = 0.5
						item_size = Vector3(1,1,1)
					"c":
						item = computer_scene
						item_placement_y = 0.5
						item_size = Vector3(2,1,2)
					"3":
						item = wall
						item_placement_y = 2.5
						item_placement_rot = 90
						item_size = Vector3(5, 5, 0.25)
					"w":
						item = wall
						item_placement_y = 2.5
						item_size = Vector3(5, 5, 0.25)
					"b":
						item = cart
						item_placement_y = 0.198
					"d":
						item = dewey
						item_placement_y = .8
					"l":
						item = librarian
						item_placement_y = .75
					"e":
						item = elevator
						item_placement_y = 1
				if (item):
					output_array.append({
						"object": item,
						"size": item_size,
						"position": Vector3(colNum,item_placement_y,rowNum), 
						"rot": Vector3(0,item_placement_rot,0)
					})
					item = null
				colNum += 1
			colNum = -25
			rowNum += 1
		rowNum = -25

static func load_ceiling(output_array):
	var item = null
	var item_placement_y = 0
	var item_placement_rot = 0
	print("Loading ceiling tiles.")
	item_placement_y = 5
	item_placement_rot = 180
	for x in range(rowNum, -rowNum):
		for y in range(colNum, -colNum):
			item = shiny_ceiling
			if (item):
				output_array.append({
					"object": item,
					"size": null,
					"position": Vector3(colNum,item_placement_y,rowNum), 
					"rot": Vector3(item_placement_rot,0,0)
				})
				item = null
			colNum += 1
		colNum = -25
		rowNum += 1
	rowNum = -25
