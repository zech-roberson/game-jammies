extends Control

@export var game_manager : GameManager

func _on_back_button_pressed() -> void:
	game_manager.game_paused = false

func _on_notes_screen_pressed() -> void:
	pass # Replace with function body.

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	hide()
	game_manager.connect("toggle_game_pause", _on_game_manager_toggle_game_pause)

func _process(_delta: float) -> void:
	pass
	
func _on_game_manager_toggle_game_pause(is_paused: bool):
	if is_paused:
		show()
	else: 
		hide()
