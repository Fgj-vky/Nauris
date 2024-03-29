extends Node2D
class_name King

var loseCallback: Callable

@onready var kingSprite = $KingSprite
@onready var kingReactionIconSprite = $"SpeeckBuble/King Reaction Icon"
@onready var speechBubbule = $SpeeckBuble
@export var jester: Jester
@export var ui: Ui
@onready var log: Log = ui.getLog()

@onready var animation = $AnimationPlayer

@onready var global = $"/root/Global" as Globals

var moodFrame = 0
var mood = 0.5 # Goes from 0.0 to 1.0

@export var maxMoodDecayRateInSeconds:float
@export var moodDecayAmount:float
@export var moodDecayDecay: float
var decayRate: float


var moodTimer:float
# Called when the node enters the scene tree for the first time.
func _ready():
	react(0)
	log.clear()
	decayRate = maxMoodDecayRateInSeconds * exp(-moodDecayDecay * (global.currentDay - 1))
	moodTimer = decayRate
	kingReactionIconSprite.visible = false
	speechBubbule.visible = false
	animation.play("new_animation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moodTimer -= delta
	if(moodTimer <= 0):
		mood -= moodDecayAmount
		mood = max(min(mood, 1.0), 0.0)
		moodFrame = 5 - (round(4 * mood)) as int
		kingSprite.frame = moodFrame	
		moodTimer = decayRate
		if(mood <= 0):
			loseCallback.call()
	
func showReaction(frameId: int, funny: int):
	print("Reacting " + str(frameId - 5))
	log.logKingReaction(funny, frameId)
	
	if funny > 0:
		kingReactionIconSprite.visible = true
		speechBubbule.visible = true
		kingReactionIconSprite.frame = 21
	elif funny < 0:
		jester.sweat()
		kingReactionIconSprite.visible = true
		speechBubbule.visible = true
		kingReactionIconSprite.frame = 22
	kingSprite.frame = frameId
	await get_tree().create_timer(1).timeout
	kingSprite.frame = moodFrame
	kingReactionIconSprite.visible = false
	speechBubbule.visible = false
	jester.idle()
	
	
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
	var funny = 0
	
	if moodChange > 0:
		reactionFrame -= 1
		funny += 1
	elif moodChange < 0:
		reactionFrame += 1
		funny -= 1
	if (reactionFrame != moodFrame):
		reactionFrame = max(min(reactionFrame, 10), 6)
		showReaction(reactionFrame, funny)
	print("Mood frame: " + str(moodFrame))
	
	
