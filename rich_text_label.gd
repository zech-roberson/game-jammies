extends RichTextLabel

var lintro = "Hello! Come on in, what can I help you with?"

var pintro = "Hi, I’m here for the job posting."

var lexcite = "Oh, I’m so glad someone finally picked that up, I appreciate you being willing to help out at our little library."

var presponse = "Of course, I’m happy to help, I needed a job anyways."

var lresponse = "Good, I’m glad you have such a sensible attitude! I did read in the paper about how the economy has been so difficult for young ones such as yourself… \n Was a shame when my last assistant left, and running a library all by myself is tiring work for an elderly lady such as myself."

var pquest = "Why did the last assistant leave?"

var lanswer = "Oh, this generation doesn’t know anything about work ethic. \n At least you seem like a sensible little thing who could actually get things done around here. Speaking of which, let’s get some books shelved."

var linstruct = "Book carts are located right here by the administrative desk on each floor. \n I’ve already taken the returned books and organized them on each floor of the library, so you don’t have to worry about bringing these books to other floors. \n Go ahead sweetie, pick up a book."

var tutText = "Press E to interact with the book cart. The book’s outline should indicate where the book goes on this floor, put colors with their matching pair."

var lencourage = "You’re a natural! Once you’re done with this floor, you may take the elevator to another floor and continue shelving the books on that floor. \n Don’t worry about visiting the basement today, the books that go down there won't be read again."

var lhavetogo = "Oh! Look at the time, I’m about to be late for a meeting! Please continue working, and I will be back later to check on your progress."

var tutTextArray:Array[String] = [lintro, pintro, lexcite, presponse, lresponse, pquest, lanswer, linstruct, tutText, lencourage, lhavetogo]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for text in tutTextArray:
		typeTxt(text)
		await get_tree().create_timer(20).timeout
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func typeTxt (input_text: String) -> void:
	visible_characters = 0
	text = input_text
	
	for i in get_parsed_text():
		visible_characters +=1
		await get_tree().create_timer(0.075).timeout
