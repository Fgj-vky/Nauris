extends Node2D
class_name Card

@export var sprite: TextureRect

@export var riseAmount: float
var offsetPos: Vector2
var originalPos: Vector2

@onready var textLabel = $Label

var resource:CardResource

@onready var iconRect = $TextureRect2

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
	print("card clicked")

func SetCardInfo(cardResource:CardResource):
	resource = cardResource
	textLabel.text = resource.cardName
	iconRect.texture = resource.image
	match resource.cardType:
		CardResource.CardType.PunchLine:
			sprite.texture = greenBg
		CardResource.CardType.Theme:
			sprite.texture = redBg
		CardResource.CardType.Subject:
			sprite.texture = blueBg
