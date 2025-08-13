extends Label

@onready var pointText = $"."
var points: int = 0

func _ready() -> void:
	pointText.text = str(points) + " Points"
	
func addPoint():
	points += 1
	pointText.text = str(points) + " Points"
	
