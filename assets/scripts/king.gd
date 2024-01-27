extends Node2D
class_name King

var moodMeter = 0.5 # Goes from 0.0 to 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func updateMood(moodChange: float):
	moodMeter += moodChange
	moodChange = max(min(moodChange, 1.0), 0.0)
	
