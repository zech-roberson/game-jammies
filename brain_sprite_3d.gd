extends Node3D

@onready var brain = $AnimatedSprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brain.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
