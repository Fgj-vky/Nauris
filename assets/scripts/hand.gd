extends Node2D
class_name Hand

var cards: Array[Card] = []

@onready var global = $"/root/Global" as Globals
@onready var ui = $"../Ui"

var startingCardCount: int
@export var fanLimit: float
@export var fanLimitCardTarget: int

@export var maxCards:int
@export var minCards:int
@export var cardDecay:float

@export var heightCurve: Curve
@export var rotationCurve: Curve

@export var rotationLimit: float
@export var fanHeight: float

@export_dir var resourcePath: String

@onready var cardsNode =  $Cards

@export var cardResources:Array[CardResource]

var cardScene: PackedScene = preload("res://assets/scenes/card_system/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	startingCardCount = max(maxCards * exp(-cardDecay * (global.currentDay - 1)), minCards)
	dir_contents(resourcePath)
	for i in range(startingCardCount):
		createRandomCard()	

func createCard(resource:CardResource):
		var card = cardScene.instantiate()
		addCardToHand(card)
		(card as Card).SetCardInfo(resource)

func createRandomCard():
	if(!cards.any(func(c): return c.resource.cardType == CardResource.CardType.Subject)):
		createCard(cardResources
			.filter(func(c): return c.cardType == CardResource.CardType.Subject)
			.pick_random())
		return
	if(!cards.any(func(c): return c.resource.cardType == CardResource.CardType.Theme)):
		createCard(cardResources
			.filter(func(c): return c.cardType == CardResource.CardType.Theme)
			.pick_random())
		return
	if(!cards.any(func(c): return c.resource.cardType == CardResource.CardType.PunchLine)):
		createCard(cardResources
			.filter(func(c): return c.cardType == CardResource.CardType.PunchLine)
			.pick_random())
		return
	createCard(cardResources.pick_random())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func calculateCardPositions():
	
	if cards.size() == 1:
		cards[0].position = Vector2(0,0) 
		cards[0].rotation = 0
		return
	
	var fanLimitFactor = min(cards.size() as float / fanLimitCardTarget as float, 1.0)
	
	var leftLimit: Vector2 =  -Vector2(fanLimit * fanLimitFactor, 0)
	var rightLimit: Vector2 = Vector2(fanLimit * fanLimitFactor, 0)
	var fanTravelVector = rightLimit - leftLimit
	for i in range(cards.size()):
		#var card = cardScene.instantiate()
		#cardsNode.add_child(card)
		var card = cards[i]
		
		var ratio = i as float / (cards.size() - 1)
		var pos = leftLimit + fanTravelVector * ratio
		pos += Vector2(0, -heightCurve.sample(ratio) * fanHeight)
		card.tweenToPos(pos)
		
		card.rotation = deg_to_rad(rotationCurve.sample(ratio) * rotationLimit)

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				dir_contents(dir.get_current_dir() + "/" + file_name)
			else:
				cardResources.append(load(dir.get_current_dir() + "/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func moveCardToTable(card: Card):
	var cardIndex = null
	for i in range(cards.size()):
		if cards[i] == card:
			cardIndex = i
	if cardIndex != null and ui.checkForSpace():
		card.tempCardPosition = card.global_position
		card.removeFromHand()
		cards.remove_at(cardIndex)
		cardsNode.remove_child(card)
		calculateCardPositions()
		ui.addCardToTable(card)
	else:
		# Card could not be added, set its hand back to this
		card.setHand($'.')
	
func addCardToHand(card: Card):
	cards.append(card)
	cardsNode.add_child(card)
	card.setHand($'.')
	calculateCardPositions()
	
