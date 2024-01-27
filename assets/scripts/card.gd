extends Node2D
class_name Card

@onready var sprite = $TextureRect

@export var riseAmount: float
var offsetPos: Vector2
var originalPos: Vector2

var hand: Hand

@onready var textLabel = $Label

var tempCardPosition = null

var resource:CardResource

@onready var iconRect = $Icon

static var redBg = preload("res://assets/sprites/card_red.png")
static var blueBg = preload("res://assets/sprites/card_blue.png")
static var greenBg = preload("res://assets/sprites/card_green.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	originalPos = sprite.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_rect_mouse_entered():
	if hand != null:
		sprite.z_index = 1000
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "position", originalPos - Vector2(0, riseAmount), 0.1)
		tween.tween_property(sprite, "modulate", Color(0.65,0.73,0.65,1), 0.1)

func _on_texture_rect_mouse_exited():
	sprite.z_index = 0
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "position", originalPos, 0.1)
	tween.tween_property(sprite, "modulate", Color(1,1,1,1), 0.1)

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
	var tween = get_tree().create_tween()
	tween.tween_property($'.', "position", pos, 0.2)

func tweenToRotation(r: float):
	var tween = get_tree().create_tween()
	tween.tween_property($'.', "rotation", r, 0.2)
