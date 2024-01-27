extends Node2D
class_name Card

@onready var sprite = $TextureRect

@export var riseAmount: float
var offsetPos: Vector2
var originalPos: Vector2

var hand: Hand

@onready var textLabel = $TextureRect/Label

var tempCardPosition = null

var resource:CardResource

@onready var iconRect = $TextureRect/Icon

static var redBg = preload("res://assets/sprites/card_red.png")
static var blueBg = preload("res://assets/sprites/card_blue.png")
static var greenBg = preload("res://assets/sprites/card_green.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_rect_mouse_entered():
	if hand != null:
		sprite.z_index = 1000
		var tween = get_tree().create_tween()
		tween.tween_property($'.', "position", tempCardPosition - Vector2(0, riseAmount), 0.1)
		tween.tween_property($'.', "modulate", Color(0.65,0.73,0.65,1), 0.1)

func _on_texture_rect_mouse_exited():
	sprite.z_index = 0
	var tween = get_tree().create_tween()
	tween.tween_property($'.', "position", tempCardPosition, 0.1)
	tween.tween_property($'.', "modulate", Color(1,1,1,1), 0.1)

func _on_texture_button_pressed():
	if hand != null:
		moveToTable()

func SetCardInfo(cardResource:CardResource):
	resource = cardResource
	textLabel.text = resource.cardName
	iconRect.frame = resource.imageIndex
	match resource.cardType:
		CardResource.CardType.PunchLine:
			sprite.texture = greenBg
		CardResource.CardType.Theme:
			sprite.texture = redBg
		CardResource.CardType.Subject:
			sprite.texture = blueBg
			
func setHand(hand_: Hand):
	hand = hand_
	
func moveToTable():
	hand.moveCardToTable($'.')
	
func removeFromHand():
	hand = null

func tweenToPos(pos: Vector2):
	tempCardPosition = pos
	var tween = get_tree().create_tween()
	tween.tween_property($'.', "position", pos, 0.2)

func tweenToRotation(r: float):
	var tween = get_tree().create_tween()
	tween.tween_property($'.', "rotation", r, 0.2)

func cardPlayed():
	var tween = get_tree().create_tween()
	var rotationAmount = (randi() % 41 + 10) as float / 100.0
	var speed = (randi() % 4 + 2) as float / 10.0
	var dir = 1 if randi() % 2 == 0 else -1
	tween.tween_property($'.', "rotation", dir * rotationAmount, speed)
	tween.tween_property($'.', "rotation", dir * -rotationAmount, speed)
	tween.set_loops()
