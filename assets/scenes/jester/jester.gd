extends Node2D
class_name Jester

@onready var sprite = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.

func _ready():
	sprite.play("idle")
	animation.play("new_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func speak():
	sprite.play("speak")

func idle():
	sprite.play("idle")
	
func sweat():
	sprite.play('sweat')
