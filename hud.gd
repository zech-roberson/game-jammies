extends CanvasLayer

@onready var brain = $"MenuBar/Brain Sprite/AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/Control/BooksCount.text = str(0)
	brain.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/Control/BooksCount.text = str(Global.Books)
	# Handle Collision inside the object itself
