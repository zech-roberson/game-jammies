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
func _process(delta: float) -> void:
	match Global.floor_number:
		1: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_1 - Global.books_shelved)
		2: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_2 - Global.books_shelved)
		3: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_3 - Global.books_shelved)
		4: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_4 - Global.books_shelved)
		5: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_5 - Global.books_shelved)
		6: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_6 - Global.books_shelved)
		7: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_7 - Global.books_shelved)
		8: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_8 - Global.books_shelved)
		9: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_9 - Global.books_shelved)
		10: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_10 - Global.books_shelved)
		11: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_11 - Global.books_shelved)
		12: 
			$Panel/Control/BooksCount.text = str(Global.books_left_to_shelve_floor_12 - Global.books_shelved)
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
