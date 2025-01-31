extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func isInteractable(): 
	pass
	
func isBookCart():
	pass

func _on_book_cart_zone_body_entered(body: Node3D) -> void:
	Global.interactable_object_in_range = Global.INTERACTABLE.CART
	
func _on_book_cart_zone_body_exited(body: Node3D) -> void:
	Global.interactable_object_in_range = Global.INTERACTABLE.NONE
