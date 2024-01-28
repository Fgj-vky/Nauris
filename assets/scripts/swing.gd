extends Node

@export var setSpeed: float
@export var setTime: float

func _ready():
	var speed = setTime if setTime > 0 else randf_range(0.5, 0.75)
	var amount = setSpeed if setSpeed > 0 else randf_range(0.1, 0.2)
	var tween = get_tree().create_tween()
	tween.tween_property($".", "rotation", amount, speed)
	tween.tween_property($".", "rotation",- amount, speed)
	tween.set_loops()
