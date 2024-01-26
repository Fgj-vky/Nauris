extends Node2D

@export var sprite: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_rect_mouse_entered():
	sprite.modulate = Color(0.65,0.73,0.65,1)
	sprite.z_index = 1000
	sprite.position += Vector2(0, -20)


func _on_texture_rect_mouse_exited():
	sprite.modulate = Color(1,1,1,1)
	sprite.z_index = 0
	sprite.position += Vector2(0, 20)
