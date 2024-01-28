extends DirectionalLight3D

const dayStartDeg: float = 125
const dayEndDeg: float = -60
var totalRotation: float

var dayProgress: float = 0

@onready var global = $"/root/Global" as Globals

var lengthOfDay: float = 120
@onready var sunPivot = $".."

var rotationStep: float


# Called when the node enters the scene tree for the first time.
func _ready():
	totalRotation = dayStartDeg - dayEndDeg
	
	rotationStep = (dayStartDeg - dayEndDeg) / (lengthOfDay * 60 * 60)


func _physics_process(delta):
	sunPivot.rotation_degrees.z = lerp(0.0, totalRotation, dayProgress)
	print(dayProgress)
	print(sunPivot.rotation_degrees.z)
