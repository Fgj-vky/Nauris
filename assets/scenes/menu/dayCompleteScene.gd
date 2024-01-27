extends CanvasLayer


@onready var global = $"/root/Global" as Globals
var nextScenePath


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.rtxOn:
		nextScenePath = "res://assets/scenes/game/rtx_game.tscn"
	else:
		nextScenePath = "res://assets/scenes/card_system/hand_demo.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file(nextScenePath)
