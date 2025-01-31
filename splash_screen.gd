extends Node2D

#@onready var splash_player = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass #splash_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if $VideoStreamPlayer.finished:
		#await get_tree().create_timer(10).timeout
		get_tree().change_scene_to_file("res://game.tscn")
