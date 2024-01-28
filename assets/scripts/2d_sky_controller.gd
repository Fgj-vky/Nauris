extends Node2D

const sunRotStart = -35
const sunRotEnd = -135

var totalRot

@onready var GameController = $"/root/HandDemo/GameController"
@onready var sunPivot = $SunPivot
@onready var sky = $SkyGradient

@export_color_no_alpha var skyTopDay: Color
@export_color_no_alpha var skyBottomDay: Color
@export_color_no_alpha var skyTopNight: Color
@export_color_no_alpha var skyBottomNight: Color

var skyGradient: Gradient


func _ready():
	var viewport = get_viewport().size
	sky.texture.width = viewport.x
	sky.texture.height = viewport.y
	sky.offset.x = viewport.x / 2
	sky.offset.y = viewport.y / 2
	
	var totalRot: float = sunRotEnd - sunRotStart
	sunPivot.rotation_degrees = sunRotStart

	skyGradient = sky.texture.gradient
	skyGradient.set_color(0, Color(0.0, 0.0, 0.0))
	# skyGradient.set_color(0, Color(1.0, 1.0, 1.0))

func _process(delta):
	skyGradient.set_color(0, skyTopDay)
	# sunPivot.rotation_degrees = lerp(sunRotStart, sunRotEnd, GameController.dayProgress)
