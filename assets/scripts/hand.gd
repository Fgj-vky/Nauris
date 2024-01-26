extends Node2D

var cards = []


@export var cardCount: int
@export var fanLimit: float

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
	calulcateCardPositions()
	dir_contents(resourcePath)
	for card in cardResources:
		print(card.cardName)


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
		
		card.rotation = deg_to_rad(rotationCurve.sample(ratio) * rotationLimit)
		cards.append(card)

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
