extends Resource
class_name CardResource

@export var cardType: CardType
@export var cardName: String
@export var combatibleCards:Array[CardResource]
@export var incombatibleCards:Array[CardResource]
@export var imageIndex:int
@export var logTextVariation: String

enum CardType {
	Theme,
	Subject,
	PunchLine
}
