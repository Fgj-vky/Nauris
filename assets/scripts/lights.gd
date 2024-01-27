extends Node3D

@onready var light1 = $OmniLight3D

var lights
var time: float = 0
var offsets: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	lights = get_children()
	for light in lights:
		offsets.append(randf_range(0.00, 4))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(lights.size()):
		lights[i].light_energy = lerp(1, 3, ((sin(time + offsets[i]) + 1) / 2))
		time += delta / 3
		#ffset += randf_range(0.05, 1.0) 

