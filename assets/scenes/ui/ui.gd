extends CanvasLayer

@onready var cardHolder = $Cards

var slot1: Card
var slot2: Card
var slot3: Card
@onready var hand = $"../Hand" as Hand
@onready var slotPos1 = $MarginContainer/TextureRect/slotPos1
@onready var slotPos2 = $MarginContainer/TextureRect/slotPos2
@onready var slotPos3 = $MarginContainer/TextureRect/slotPos3

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
	if slot1 != null && slot2 != null && slot3 != null:
		playCards()
		
		
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

func removeCards():
	if slot1.resource.cardType != CardResource.CardType.Theme || slot2.resource.cardType != CardResource.CardType.Subject || slot3.resource.cardType != CardResource.CardType.PunchLine:
		#return
		pass
	slot1.queue_free()
	slot1 = null
	slot2.queue_free()
	slot2 = null
	slot3.queue_free()
	slot3 = null
	hand.createRandomCard()
	hand.createRandomCard()
	hand.createRandomCard()

func playCards():
	await get_tree().create_timer(1).timeout
	removeCards()
