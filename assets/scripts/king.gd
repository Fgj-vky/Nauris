extends Node2D
class_name King

var loseCallback: Callable

@onready var kingSprite = $KingSprite
@onready var kingReactionIconSprite = $"SpeeckBuble/King Reaction Icon"
@onready var speechBubbule = $SpeeckBuble

var moodFrame = 0
var mood = 0.5 # Goes from 0.0 to 1.0

@export var moodDecayRateInSeconds:float
@export var moodDecayAmount:float
var moodTimer:float
# Called when the node enters the scene tree for the first time.
func _ready():
	react(0)
	moodTimer = moodDecayRateInSeconds
	kingReactionIconSprite.visible = false
	speechBubbule.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moodTimer -= delta
	if(moodTimer <= 0):
		mood -= moodDecayAmount
		mood = max(min(mood, 1.0), 0.0)
		moodFrame = 5 - (round(4 * mood)) as int
		kingSprite.frame = moodFrame	
		moodTimer = moodDecayRateInSeconds
		if(mood <= 0):
			loseCallback.call()
	
func showReaction(frameId: int, funny: bool):
	print("Reacting " + str(frameId - 5))
	kingReactionIconSprite.visible = true
	speechBubbule.visible = true
	print(funny)
	if !funny:
		kingReactionIconSprite.frame = 22
	else:
		kingReactionIconSprite.frame = 21
	kingSprite.frame = frameId
	await get_tree().create_timer(1).timeout
	kingSprite.frame = moodFrame
	kingReactionIconSprite.visible = false
	speechBubbule.visible = false
	
	
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
		var funny = moodChange > 0
		showReaction(reactionFrame, funny)
	print("Mood frame: " + str(moodFrame))
	
	
