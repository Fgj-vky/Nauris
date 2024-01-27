extends CanvasLayer


@onready var global = $"/root/Global" as Globals

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	global.currentDay = 0;
	get_tree().change_scene_to_file("res://assets/scenes/menu/main_menu.tscn")
