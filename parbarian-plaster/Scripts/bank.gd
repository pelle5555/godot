extends MarginContainer

@export var starting_gold: int = 150
@onready var gold_text: Label = $GoldText

var gold: int:
	set(gold_in):
		gold = max(gold_in, 0)
		gold_text.text = "Gold: " + str(gold)
			

func _ready() -> void:
	gold = starting_gold
	Engine.time_scale = 5
