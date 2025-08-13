extends Node

var chance := 0.2
var chance_pct: int:
	get:
		return chance * 100
	set(value): 
		chance = float(value) / 100.0
		

func _ready() -> void:
	print(chance_pct)
	chance = 0.6
	print(chance_pct)
