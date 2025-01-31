extends Node

class_name GameManager
signal toggle_game_pause(is_paused: bool)

var current_floor = null
var current_floor_num = 0

func _ready() -> void:
	current_floor = load("res://floors/1/floor.tscn")
	add_child(current_floor.instantiate())
	current_floor_num += 1

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_pause", game_paused)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		game_paused = !game_paused

func _process(delta: float) -> void:
	if current_floor_num != Global.next_floor:
		current_floor_num += 1
		Global.books_shelved = 0
		get_tree().change_scene_to_file("res://floors/"+str(current_floor_num)+"/floor.tscn")
