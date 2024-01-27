extends Node2D

@export var king: King
var time = 10.0 # time in seconds left 
var levelActive = true

var score:int
@export var scoreMultiplier:int

@onready var global = $"/root/Global" as Globals

# Called when the node enters the scene tree for the first time.
func _ready():
	king.loseCallback = lose
	score = 0;	
	if(global.currentDay == null):
		global.currentDay = 0
	global.currentDay += 1
	print("Current day: " + str(global.currentDay))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time > 0:
		time -= delta
	elif levelActive:
		endLevel()

func endLevel():
	levelActive = false
	if king.mood > 0.25:
		win()
	else:
		lose()

func addScore(amout:float):
	score = scoreMultiplier * amout
	print("Current score: " + str(score))

func win():
	print("You win")
	get_tree().reload_current_scene()
	
func lose():
	print("You lose")
