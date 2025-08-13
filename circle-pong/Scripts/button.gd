extends Button

@onready var _BALL = $"../../Ball"
@export var button_type: String

func _on_pressed() -> void:
	if button_type:
		_BALL.gavity_change(button_type)
