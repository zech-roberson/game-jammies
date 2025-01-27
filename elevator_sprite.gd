extends Node3D

@onready var sprite = $AnimatedSprite3D

var isOpen = false
var isClosed = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("close")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.interactable_object_in_range == Global.INTERACTABLE.ELEVATOR && Global.books_shelved == 10 && isClosed:
		sprite.play("open")
		isOpen = true
		isClosed = false
	elif Global.interactable_object_in_range == Global.INTERACTABLE.NONE && Global.books_shelved == 10 && isOpen: 
		sprite.play("close")
		isOpen = false
		isClosed = true
