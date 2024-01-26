extends Node2D

@export var sprite: TextureRect

@export var riseAmount: float

var offsetPos: Vector2
var originalPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPos = sprite.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_rect_mouse_entered():
	sprite.z_index = 1000
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "position", originalPos - Vector2(0, riseAmount), 0.1)
	tween.tween_property(sprite, "modulate", Color(0.65,0.73,0.65,1), 0.1)
	


func _on_texture_rect_mouse_exited():
	sprite.z_index = 0
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "position", originalPos, 0.1)
	tween.tween_property(sprite, "modulate", Color(1,1,1,1), 0.1)


func _on_texture_button_pressed():
	print("card clicked")
