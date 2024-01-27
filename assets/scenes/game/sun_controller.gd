extends DirectionalLight3D

const dayStartDeg: float = 125
const dayEndDeg: float = -60

var dayProgress: float = 0

var lengthOfDay: float = 120
@onready var dayTimer = $DayTimer

var rotationStep: float


# Called when the node enters the scene tree for the first time.
func _ready():
	dayTimer.wait_time = lengthOfDay
	dayTimer.start()
	
	rotationStep = (dayStartDeg - dayEndDeg) / (lengthOfDay * 60 * 60)


func _physics_process(delta):
	rotate_z(rad_to_deg(rotationStep * delta))
