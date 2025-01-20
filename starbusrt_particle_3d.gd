extends Node3D

@onready var star = $AnimatedSprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	star.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
