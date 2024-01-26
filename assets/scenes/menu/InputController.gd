extends Node

@export var shouldEscQuit: bool

@export_file var mainMenuScene: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if(Input.is_action_just_pressed("quit")):
		if(shouldEscQuit):
			get_tree().quit()
		else:
			get_tree().change_scene_to_file(mainMenuScene)
