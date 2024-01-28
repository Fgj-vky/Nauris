extends Control
class_name Log

@onready var textLabel = $Panel/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func log(card1: Card, card2: Card, card3: Card):
	var theme = (card1 as Card).resource.cardName
	var subject = (card2 as Card).resource.cardName
	var pl = (card3 as Card).resource.cardName
	
	textLabel.append_text("You tell the king a " + pl + " " + theme + "joke" + " about the " + subject + "\n")

