extends DirectionalLight3D

const dayStartDeg: float = 125
const dayEndDeg: float = -70
var totalRotation: float

var dayProgress: float = 0

@onready var GameController = $"/root/Node3D/GameController"

var lengthOfDay: float = 120
@onready var sunPivot = $".."

var rotationStep: float


func _ready():
	totalRotation = dayStartDeg - dayEndDeg


func _physics_process(delta):
	sunPivot.rotation_degrees.z = lerp(0.0, totalRotation, GameController.dayProgress)
