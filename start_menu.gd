extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://text_level.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_leave_pressed() -> void:
	get_tree().quit()
