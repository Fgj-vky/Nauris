extends CanvasLayer

var slot1: Card
var slot2: Card
var slot3: Card

func addCardToTable(card: Card): 
	# Add card to next slot if free
	if slot1 == null:
		slot1 = card
	elif slot2 == null:
		slot2 = card
	elif slot3 == null:
		slot3 = card
		
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
