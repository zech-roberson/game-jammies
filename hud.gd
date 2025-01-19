extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/CenterContainer/Control/BooksCount.text = str(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/CenterContainer/Control/BooksCount.text = str(Global.Books)
	# Handle Collision inside the object itself
	
	if not Global.has_escape_been_pressed:
		visible = true
	else:
		visible = false
