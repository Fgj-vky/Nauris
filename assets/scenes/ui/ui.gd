extends CanvasLayer
class_name Ui

@onready var cardHolder = $Cards
@export var king: King

@onready var gameController = $"../GameController"
@onready var jester: Jester = $"../Jester" as Jester
@onready var events: eventSystem = $"../EventSystem" as eventSystem
@onready var eventPanel = $EventPanel
@onready var eventlabel = $EventPanel/Label

var slot1: Card
var slot2: Card
var slot3: Card
@onready var hand = $"../Hand" as Hand
@onready var slotPos1 = $MarginContainer/TextureRect/slotPos1
@onready var slotPos2 = $MarginContainer/TextureRect/slotPos2
@onready var slotPos3 = $MarginContainer/TextureRect/slotPos3

@onready var logPanel: Log = $Log

var cardDict = {}
var cardData = preload("res://assets/Book2.csv").records

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
	formDict()
	hideEventInfo()
	
func formDict():
	for data in cardData:
		if(cardDict.has(data[0])):
			cardDict[data[0]].append(data[1])
		else:
			cardDict[data[0]] = [data[1]]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func removeCards():
	if slot1.resource.cardType != CardResource.CardType.Theme || slot2.resource.cardType != CardResource.CardType.Subject || slot3.resource.cardType != CardResource.CardType.PunchLine:
		king.react(-0.1)
		logPanel.log(slot1, slot2, slot3, false)
	else:
		var score = calculateMoodScore()
		king.react(score)
		gameController.addScore(score)
		logPanel.log(slot1, slot2, slot3, true)
	slot1.queue_free()
	slot1 = null
	slot2.queue_free()
	slot2 = null
	slot3.queue_free()
	slot3 = null
	hand.createRandomCard()
	hand.createRandomCard()
	hand.createRandomCard()

func calculateMoodScore():
	
	var cards = [slot1, slot2, slot3]
	var bonus = 0
	for card in cards:
		var resource = (card as Card).resource
		if(!cardDict.has(resource.cardName)): continue
		var combitables = cardDict[resource.cardName]
		for com in combitables:
			for testCard in cards:
				if((testCard as Card).resource.cardName == com):
					bonus += 1
					print("Found combatible cards: " + resource.cardName + " + " + com)
	
	if bonus == 0:
		bonus = -1
	
	if(!events.eventActive):
		return bonus / 10.0
	
	var event = events.currentEvent
	for card in cards:
		var resource = card.resource
		if(event.compatibleCards.any(func(card): return card.cardName == resource.cardName)):
			bonus += 1
			print("event compatibility found: " + resource.cardName + " : " + event.name)
		if(event.inCompatibleCards.any(func(card): return card.cardName == resource.cardName)):
			bonus -= 1
			print("event in compatibility found: " + resource.cardName + " : " + event.name)
	
	event.compatibleCards
	
	return bonus / 10.0

func playCards():
	
	jester.speak()
	
	
	slot1.cardPlayed()
	slot2.cardPlayed()
	slot3.cardPlayed()
	await get_tree().create_timer(1).timeout
	removeCards()

func getLog():
	return logPanel
	
func showEventInfo(name: String):
	eventPanel.visible = true
	eventlabel.text = name + " is visiting the King"
	
func hideEventInfo():
	eventPanel.visible = false
