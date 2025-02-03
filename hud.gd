extends CanvasLayer

@onready var brain = $"MenuBar/Brain Sprite/AnimatedSprite2D"
@onready var heartBar = $MenuBar/PlayerFullHearts/HeartBoxContainer
@onready var strengthBar = $MenuBar/Strength
@onready var blockBar = $MenuBar/Block
@onready var schwiftBar = $MenuBar/Schwift

var hearts_list : Array[TextureRect]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/Control/BooksCount.text = str(0)
	brain.play("default")
	
	for child in heartBar.get_children():
		hearts_list.append(child)
		
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < Global.player_health
	
	
	strengthBar.value = Global.player_attack_power
	blockBar.value = Global.player_shield_strength
	schwiftBar.value = Global.player_sprint_speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve)
	# Handle Collision inside the object itself
	
	##Show the empty heart containers and hide the full ones, if taking damage, from right to left
	if hearts_list.size() > Global.player_health && Global.is_hurting:
		print("in hearts decrement")
		var difference_in_health = hearts_list.size() - Global.player_health
		print("diff in health", difference_in_health)
		for i in range(hearts_list.size()):
			if difference_in_health > 0:
				hearts_list[hearts_list.size() - (i+1)].hide()
			difference_in_health -= 1
	##Show the full heart containers and hide the empty ones, if healing, from left to right
	elif hearts_list.size() > Global.player_health && Global.is_healing:
		var difference_in_health = Global.player_health - hearts_list.size()
		
		for i in range(hearts_list.size()):
			if difference_in_health > 0:
				hearts_list[hearts_list.size() - (i+difference_in_health)].show()
			difference_in_health -= 1
	elif hearts_list.size() < Global.player_health:
		for i in range(hearts_list.size()):
			hearts_list[i].visible = i < Global.player_health
			
	if strengthBar.value < Global.player_attack_power:
		strengthBar.value = Global.player_attack_power
		
	if blockBar.value < Global.player_shield_strength:
		blockBar.value = Global.player_shield_strength
		
	if schwiftBar.value < Global.player_sprint_speed:
		schwiftBar.value = Global.player_sprint_speed
