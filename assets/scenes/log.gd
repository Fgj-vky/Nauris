extends Control
class_name Log

@onready var textLabel = $Panel/VBoxContainer/NarratorBox
@onready var kingBox = $Panel/VBoxContainer/ReactionBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func log(card1: Card, card2: Card, card3: Card, saneSentence: bool):
	var themeCard = (card1 as Card)
	var subject = (card2 as Card).resource.cardName
	var plCard = (card3 as Card)
	
	
	var themeVar = (themeCard as Card).resource.logTextVariation
	var themeName = (themeCard as Card).resource.cardName
	var theme = themeVar if themeVar.length() > 0 else themeName
	
	var plVar = (plCard as Card).resource.logTextVariation
	var plName = (plCard as Card).resource.cardName
	var pl = plVar if plVar.length() > 0 else plName
	
	if !saneSentence:
		textLabel.text = "You fumble your words\n"
	else:
		textLabel.text = ("You tell the king a " + theme + " joke about the " + subject + " " + pl + "\n")

func logKingReaction(funny: int, moodFrame: int):
	var reaction = "The king"
	print("MF " + str(moodFrame))
	
	if funny > 0:
		# Funny
		if moodFrame == 6:
			reaction += " can not contain his laugh"
		elif moodFrame == 7:
			reaction += " chuggles a little"
		elif moodFrame == 8:
			reaction += " finds it a bit funny"
		elif moodFrame == 9:
			reaction += "s mood seems to improve a bit"
		else:
			reaction += ": Funny"
	elif funny < 0:
		# Not funny
		if moodFrame == 10:
			reaction += ' shouts angrily: \"NOT FUNNY\"'
		elif moodFrame == 9:
			reaction += " did not like it"
		elif moodFrame == 8:
			reaction += "s smile fades away for a second"
		elif moodFrame == 7:
			reaction += " laughs akwardly, this is not it"
		else: 
			reaction += "Not Funny"
	else:
		reaction += "s face does not change, boring"
		
	kingBox.text = reaction

func clear():
	kingBox.text = ""
	textLabel.text = ""
