extends StaticBody3D

# instantiate the floor_generator class
#	necessary for all floors

var floor_generator = load("res://floors/floor.gd")
var ceiling_walls_floor = preload("res://floors/wall_ceiling_lights.tscn")

const flr_num = Global.FLOORS.FIRST
const shlv_goal = 10
var objects_array = []

@onready var interactScreen = $InteractionLayer/InteractionScreen
@onready var interactSrceenWithBookshelf = $InteractionLayer/InteractionScreenWithBookshelf
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.floor_number = flr_num
	
	Global.books_shelved = 0
	Global.books_left_to_shelve = shlv_goal
	Global.floor_done = false
	
	floor_generator.load_flooring(objects_array, "res://floors/1/floor.txt")
	floor_generator.load_furniture(objects_array, "res://floors/1/layout.txt")
	floor_generator.load_ceiling(objects_array)
	
	for object in objects_array:
		var item = object["object"].instantiate()
		add_child(item)
		# the top of flooring should always be at y level zero
		#	so lower our 1m cube half a meter
		item.set_global_position(object["position"])
		# randomly orient the floor to get some variety
		item.set_rotation_degrees(object["rot"])
		if object["size"]:
			# create collision object the same dimensions as item
			var shape3d = CollisionShape3D.new()
			var box = BoxShape3D.new()
			box.size = object["size"]
			add_child(shape3d)
			shape3d.set_shape(box)
			shape3d.set_global_position(item.get_global_position())
			shape3d.set_rotation_degrees(item.get_rotation_degrees())

	add_child(ceiling_walls_floor.instantiate())
	
	#DialogueManager.show_example_dialogue_balloon(load("res://floors/floor_dialogue/1.dialogue"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#if Global.books_left_to_shelve == 0:
	#	Global.floor_done = true
	#if Global.interactable_object_in_range == Global.INTERACTABLE.CART && Global.has_met_librarian:
	#	interactScreen.show()
	#elif Global.interactable_object_in_range == Global.INTERACTABLE.ELEVATOR && Global.books_shelved == 10:
	#	interactScreen.show()
	#elif Global.interactable_object_in_range == Global.INTERACTABLE.SHELF && Global.is_holding_book:
	#	interactSrceenWithBookshelf.show()
	#else:
	#	interactScreen.hide()
	#	interactSrceenWithBookshelf.hide()
