extends Node2D

@export var king: King
var time = 120.0 # time in seconds left 
var levelActive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time > 0:
		time -= delta
	elif levelActive:
		endLevel()

func endLevel():
	levelActive = false
