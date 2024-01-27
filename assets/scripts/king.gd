extends Node2D
class_name King

var loseCallback: Callable

@onready var kingSprite = $KingSprite

var moodFrame = 0
var mood = 0.5 # Goes from 0.0 to 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	react(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func showReaction(frameId: int):
	print("Reacting " + str(frameId - 5))
	kingSprite.frame = frameId
	await get_tree().create_timer(1).timeout
	kingSprite.frame = moodFrame
	
	
func react(moodChange: float):
	# 6 funny
	# 10 angry
	# 1 vhappy
	# 5 vsad :(
	mood += moodChange
	mood = max(min(mood, 1.0), 0.0)
	print(mood)
	moodFrame = 5 - (round(4 * mood)) as int
	kingSprite.frame = moodFrame
	
	var reactionFrame = moodFrame + 5
	if moodChange > 0:
		reactionFrame -= 1
	elif moodChange < 0:
		reactionFrame += 1
	if (reactionFrame != moodFrame):
		reactionFrame = max(min(reactionFrame, 10), 6)
		showReaction(reactionFrame)
	print("Mood frame: " + str(moodFrame))
	
	
