extends Node2D

@onready var librarian = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	librarian.play("good_walking_left")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
