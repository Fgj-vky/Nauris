extends Node2D

var cards = []


@export var cardCount: int
@export var fanLimit: float

@export var heightCurve: Curve
@export var fanHeight: float

@onready var cardsNode =  $Cards

var cardScene: PackedScene = preload("res://assets/scenes/card_system/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	calulcateCardPositions()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func calulcateCardPositions():
	var leftLimit: Vector2 =  -Vector2(fanLimit, 0)
	var rightLimit: Vector2 = Vector2(fanLimit, 0)
	var fanTravelVector = rightLimit - leftLimit
	for i in range(cardCount):
		var card = cardScene.instantiate()
		cardsNode.add_child(card)
		var ratio = i as float / (cardCount - 1)
		card.position = leftLimit + fanTravelVector * ratio
		card.position += Vector2(0, -heightCurve.sample(ratio) * fanHeight)
		cards.append(card)
