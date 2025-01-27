extends StaticBody3D

@onready var racc = $AnimatedSprite3D

func _ready() -> void:
	racc.play("default")
	
func isInteractable():
	pass

func isNPC():
	pass
	
func isDewy():
	pass
