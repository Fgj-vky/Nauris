extends Node2D
class_name King

var loseCallback: Callable

@onready var kingSprite = $KingSprite

var mood = 0.5 # Goes from 0.0 to 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	updateKingSprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func updateMood(moodChange: float):
	mood += moodChange
	moodChange = max(min(moodChange, 1.0), 0.0)
	
	if mood <= 0:
		loseCallback.call()
	updateKingSprite()
	print("King mood: " + str(mood))

func updateKingSprite():
	# 1 vhappy
	# 5 vsad(
	var frame = 5 - (round(4 * mood)) as int
	kingSprite.frame = frame
	
