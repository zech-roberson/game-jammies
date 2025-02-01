@tool
extends StaticBody3D

# instantiate the floor_generator class
#	necessary for all floors

var floor_generator = preload("res://floors/floor.gd").new(Global.FLOORS.FIRST, 10)

@onready var interactScreen = $InteractionLayer/InteractionScreen
@onready var interactSrceenWithBookshelf = $InteractionLayer/InteractionScreenWithBookshelf
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	floor_generator.load_flooring("res://floors/1/floor.txt")
	floor_generator.load_furniture("res://floors/1/layout.txt")
	floor_generator.load_ceiling()
	
	#DialogueManager.show_example_dialogue_balloon(load("res://floors/floor_dialogue/1.dialogue"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
