extends Control

@export_file var gameScene:String
@export_file var rtxScene:String

@onready var global = $"/root/Global" as Globals
@onready var helpPanel = $HelpPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	closeHelp()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_button_pressed():
	get_tree().change_scene_to_file(gameScene)

func _on_exit_button_pressed():
	get_tree().quit()

func _on_start_rtx_button_pressed():
	global.rtxOn = true
	get_tree().change_scene_to_file(rtxScene)

func showHelp():
	helpPanel.visible = true
	
func closeHelp():
	helpPanel.visible = false
