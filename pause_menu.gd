extends Control

func _on_pause_button_pressed():
	get_tree().paused = true
	show()
	
func _on_close_button_pressed():
	hide()
	get_tree().paused = false

func _on_back_button_pressed() -> void:
	hide()

func _on_notes_screen_pressed() -> void:
	pass # Replace with function body.

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
