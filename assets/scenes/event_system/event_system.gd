extends Node2D
class_name eventSystem

@export_dir var resourcePath: String
@export var resources:Array[event]

@export var maxTime: float
@export var minTime: float
var time: float

@onready var sprite = $Sprite2D

var currentEvent: event
@export var timeEventActive: float
var eventActive: bool = false
var eventTimer: float

@export var tweenOutAmount: float

func _ready():
	dir_contents(resourcePath)
	time = randf_range(minTime, maxTime)
	eventTimer = timeEventActive	
	var tween = get_tree().create_tween()
	tween.tween_property($'./Sprite2D', "rotation", 0.1, 0.5)
	tween.tween_property($'./Sprite2D', "rotation", -0.1, 0.5)
	tween.set_loops()

func _process(delta):
	if(eventActive):
		eventTimer -= delta
		if(eventTimer <= 0):
			eventActive = false
			eventTimer = timeEventActive
			hideEvent()
	else:
		time -= delta
		if(time <= 0):
			spawnEvent()
			time = randf_range(minTime, maxTime)
			eventActive = true

func spawnEvent():
	currentEvent = resources.pick_random()
	sprite.texture = currentEvent.character
	sprite.global_position = sprite.global_position + Vector2(-tweenOutAmount, 0)
	var tween = get_tree().create_tween()
	tween.tween_property($'./Sprite2D', "global_position", sprite.global_position + Vector2(tweenOutAmount, 0), 0.5)

func hideEvent():
	sprite.flip_h = true
	var tween = get_tree().create_tween()
	tween.tween_property($'./Sprite2D', "global_position", sprite.global_position + Vector2(-tweenOutAmount, 0), 0.5)
	tween.tween_callback(func(fuck): 
		sprite.texture = null
		sprite.global_position = sprite.global_position + Vector2(tweenOutAmount, 0)
		sprite.flip_hflip_h = false
		)
	

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				dir_contents(dir.get_current_dir() + "/" + file_name)
			else:
				resources.append(load(dir.get_current_dir() + "/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
