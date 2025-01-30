extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shelve_book_location = find_child("Area3D")
	shelve_book_location.set_monitoring(true)
	shelve_book_location.body_entered.connect(_on_shelve_book_location_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_shelve_book_location_entered():
	print("You entered the block!")
