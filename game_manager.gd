extends Node

class_name GameManager
signal toggle_game_pause(is_paused: bool)

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
