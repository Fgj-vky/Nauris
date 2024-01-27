extends CanvasLayer

@onready var cardHolder = $MarginContainer/Panel/HBoxContainer/Cards

var slot1: Card
var slot2: Card
var slot3: Card

@onready var slotPos1 = $MarginContainer/Panel/HBoxContainer/CardSlot/slotPos1
@onready var slotPos2 = $MarginContainer/Panel/HBoxContainer/CardSlot2/slotPos2
@onready var slotPos3 = $MarginContainer/Panel/HBoxContainer/CardSlot3/slotPos3

func addCardToTable(card: Card): 
	# Add card to next slot if free
	if slot1 == null:
		slot1 = card
		cardHolder.add_child(card)
		card.position = card.tempCardPosition
		card.tweenToPos(slotPos1.global_position)
		card.tweenToRotation(0)
	elif slot2 == null:
		slot2 = card
		cardHolder.add_child(card)
		card.position = card.tempCardPosition
		card.tweenToPos(slotPos2.global_position)
		card.tweenToRotation(0)
	elif slot3 == null:
		slot3 = card
		cardHolder.add_child(card)
		card.position = card.tempCardPosition
		card.tweenToPos(slotPos3.global_position)
		card.tweenToRotation(0)
		
func checkForSpace():
	if slot1 == null or slot2 == null or slot3 == null:
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
